$files = git status --porcelain -uall
foreach ($line in $files) {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    $status = $line.Substring(0, 2)
    $file = $line.Substring(3).Trim()
    
    if ($status -eq " D") {
        git rm $file
    } else {
        git add $file
    }
    
    git commit -m "Update $file"
}
git push origin main
