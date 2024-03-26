package transform

import rego.v1

_payload(msg) := json.unmarshal(base64.decode(msg.value))

# _id() of a message must be unique across its kind
_id(msg) := json.unmarshal(base64.decode(msg.key))

# _kind() of a message determines where on the resulting data tree its
# values are to be written. This is useful when you don't want to use the
# incoming topics as-is.
_kind(msg) := "groups" if msg.topic == "group-topic"

else := msg.topic

# _key() of a message with kind T is where we'll store its _values()
# so on kind "users", message with `_id(msg)` of "ada" and `_values(msg)`
# of {"name": "Ada Lovelace"} will end up as
#
# users:
#   ada:
#     name: Ada Lovelace
#
# in the result of the transform
_key(msg) := _payload(msg).id

_values("users", payload) := object.filter(payload, ["name", "roles"]) # for users, pluck "name" and "roles"

_values("groups", payload) := object.remove(payload, ["id", "type"]) # for groups, take everything BUT "type"

_values(kind, payload) := payload if not kind in {"users", "groups"} # for other kinds, keep message payload as-is

# this collects all IDs of the messages in a batch, per kind
batches[_kind(msg)][idx] := _key(msg) if some idx, msg in input.incoming

# incoming messages are parsed and stored under their ID payload field
transform[kind][_key(msg)] := _values(kind, payload) if {
	some kind, msgs in incoming_latest
	some _, msg in msgs
	payload := _payload(msg)
	not is_delete(payload)
}

# no "type" in the payload means "not delete" => undefined
is_delete(payload) if payload.type == "delete"

# if no new data came in for a certain message, we'll retain the data
# stored previously
transform[kind][key] := val if {
	# we cannot read existing kinds from batches, as we'd lose old data
	# that has no updates in the incoming batch
	some kind, existing in input.previous
	some key, val in existing
	no_news_for_key(kind, key)
}

no_news_for_key(kind, _) if not batches[kind]

no_news_for_key(kind, key) if not key in object.keys(incoming_latest[kind])

# input.incoming is an array, iteration order naturally given
incoming[_kind(msg)][_key(msg)][batch] := msg if some batch, msg in input.incoming

incoming_latest[kind][key] := msg if {
	some kind, xs in incoming
	some key, batch in xs

	# batch is an object! iteration order is unspecified -- but it happens to be sorted
	arr := [i | some i, _ in batch]
	last := arr[count(arr) - 1]
	msg := batch[last]
}
