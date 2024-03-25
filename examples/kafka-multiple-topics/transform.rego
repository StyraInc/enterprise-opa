package transform

import rego.v1

_payload(msg) := json.unmarshal(base64.decode(msg.value))

# _id() of a message must be unique across its topic
_id(msg) := json.unmarshal(base64.decode(msg.key))

# _key() of a message with topic T is where we'll store its _values()
# so on topic "users", message with `_id(msg)` of "ada" and `_values(msg)`
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

_values(topic, payload) := payload if not topic in {"users", "groups"} # for other topics, keep message payload as-is

# this collects all IDs of the messages in a batch, per topic
batches[msg.topic][idx] := _key(msg) if some idx, msg in input.incoming

# incoming messages are parsed and stored under their ID payload field
transform[topic][_key(msg)] := _values(topic, payload) if {
	some topic, msgs in incoming_latest
	some _, msg in msgs
	payload := _payload(msg)
	not is_delete(payload)
}

# no "type" in the payload means "not delete" => undefined
is_delete(payload) if payload.type == "delete"

# if no new data came in for a certain message, we'll retain the data
# stored previously
transform[topic][key] := val if {
	# we cannot read existing topics from batches, as we'd lose old data
	# that has no updates in the incoming batch
	some topic, existing in input.previous
	some key, val in existing
	no_news_for_key(topic, key)
}

no_news_for_key(topic, _) if not batches[topic]

no_news_for_key(topic, key) if not key in object.keys(incoming_latest[topic])

# input.incoming is an array, iteration order naturally given
incoming[msg.topic][_key(msg)][batch] := msg if some batch, msg in input.incoming

incoming_latest[topic][key] := msg if {
	some topic, xs in incoming
	some key, batch in xs

	# batch is an object! iteration order is unspecified -- but it happens to be sorted
	arr := [i | some i, _ in batch]
	last := arr[count(arr) - 1]
	msg := batch[last]
}
