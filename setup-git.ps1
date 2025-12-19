# --- AUTO GIT SETUP BY EXCEL ---
Write-Host "[ INFO ] Memulai Setup Git Otomatis..." -ForegroundColor Cyan

# 1. Minta URL Repository (SSH)
$repoUrl = Read-Host "Tempelkan URL SSH Repository (contoh: git@github.com:excelyno/repo.git)"

if ([string]::IsNullOrWhiteSpace($repoUrl)) {
    Write-Host "[ ERROR ] URL tidak boleh kosong!" -ForegroundColor Red
    exit
}

# 2. Inisialisasi Git
if (-not (Test-Path ".git")) {
    git init
    Write-Host "[ OK ] Git diinisialisasi." -ForegroundColor Green
} else {
    Write-Host "[ INFO ] Git sudah ada, melanjutkan..." -ForegroundColor Yellow
}

# 3. Buat README jika belum ada
if (-not (Test-Path "README.md")) {
    $folderName = (Get-Item -Path ".").Name
    "# $folderName" | Out-File "README.md" -Encoding utf8
    Write-Host "[ OK ] README.md dibuat." -ForegroundColor Green
}

# 4. Buat .gitignore standar
if (-not (Test-Path ".gitignore")) {
    ".vscode/`n*.log`nnode_modules/`nvendor/" | Out-File ".gitignore" -Encoding utf8
    Write-Host "[ OK ] .gitignore dibuat." -ForegroundColor Green
}

# 5. Eksekusi Perintah Git
Write-Host "[ PROSES ] Sedang membungkus file..." -ForegroundColor Cyan
git branch -M main
git add .
git commit -m "First commit by Auto-Script"

# 6. Cek Remote
git remote remove origin 2>$null 
git remote add origin $repoUrl

# 7. Push
Write-Host "[ PROSES ] Sedang menerbangkan ke GitHub..." -ForegroundColor Cyan
git push -u origin main

Write-Host "----------------------------------"
Write-Host "[ SUKSES ] Project sudah online!" -ForegroundColor Green
Write-Host "----------------------------------"