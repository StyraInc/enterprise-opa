Output memory.gif

Set Shell "bash"
Set Width 1200
Set Height 600
Set TypingSpeed 0.03

Hide
Type "# Check memory usage of Styra Enterprise OPA"
Show
Sleep 200ms
Enter
Type "curl 'http://localhost:8181/metrics/alloc_bytes?pretty=true'"
Sleep 500ms
Enter
Enter

Sleep 1s

Hide
Type "# Check memory usage of OPA"
Show
Sleep 200ms
Enter
Type "curl 'http://localhost:8282/metrics/alloc_bytes?pretty=true'"
Sleep 500ms
Enter

Sleep 5s
