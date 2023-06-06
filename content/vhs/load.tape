Output load.gif

Require brew

Set Shell "bash"
Set Width 1200
Set Height 600
Set TypingSpeed 0.03

Type "brew install styrainc/packages/load"
Sleep 500ms
Enter
Sleep 8s

Ctrl+L

Type "export STYRA_LOAD_LICENSE_KEY=CHANGEME"
Sleep 1500ms
Enter
Sleep 200ms

Ctrl+L

Type "# Starting Styra Enterprise OPA with a large (400MB) RBAC bundle"
Sleep 200ms
Enter
Type "eopa run -s https://dl.styra.com/enterprise-opa/bundle-enterprise-opa-400.tar.gz"
Sleep 500ms
Enter

# "Wait for Enterprise OPA to download and activate the bundle"

Sleep 3s

