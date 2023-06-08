Output enterprise-opa.gif

Require brew

Set Shell "bash"
Set Width 1200
Set Height 600
Set TypingSpeed 0.03

Type "brew install -q styrainc/packages/eopa"
Enter
Sleep 2s

Require eopa

Type "export EOPA_LICENSE_KEY=YOUR-LICENSE-HERE"
Sleep 1500ms
Hide
Ctrl+C

Ctrl+L

Type "# Starting Styra Enterprise OPA with a large (400MB) RBAC bundle"
Show
Sleep 200ms
Enter
Type "eopa run -s https://dl.styra.com/enterprise-opa/bundle-enterprise-opa-400.tar.gz"
Sleep 500ms
Enter

# "Wait for Enterprise OPA to download and activate the bundle"

Sleep 3s

