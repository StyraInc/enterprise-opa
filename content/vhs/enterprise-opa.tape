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

Hide
Type "# Start a trial!"
Enter
Sleep 200ms
Show
Type "eopa license trial \"
Enter
Type "  --first-name Bobby \"
Enter
Type "  --last-name Tables \"
Enter
Type "  --email bobby@styra.com \"
Enter
Type "  --company 'Acme Inc' \"
Enter
Type "  --country US \"
Enter
Type "  --key-only > license_key"
Enter
Sleep 4s

Type "export EOPA_LICENSE_KEY=$(cat license_key)"
Enter
Sleep 500ms
Type "eopa license"
Enter
Sleep 4s

Ctrl+L

Hide
Type "# Starting Enterprise OPA with a large (400MB) RBAC bundle"
Show
Sleep 200ms
Enter
Type "eopa run -s https://dl.styra.com/enterprise-opa/bundle-enterprise-opa-400.tar.gz"
Sleep 500ms
Enter

# "Wait for Enterprise OPA to download and activate the bundle"

Sleep 3s

