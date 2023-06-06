Output opa.gif

Set Shell "bash"
Set Width 1200
Set Height 600
Set TypingSpeed 0.03

Type "# Starting OPA with a large (400MB) RBAC bundle"
Sleep 200ms
Enter
Type "opa run -s -a localhost:8282 https://dl.styra.com/enterprise-opa/bundle-opa-400.tar.gz"
Sleep 500ms
Enter

# "Wait for OPA to download and activate the bundle"

Sleep 3s
