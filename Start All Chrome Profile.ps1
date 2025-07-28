# MIT License
#
# Copyright (c) 2025 Fadi Al Kanani
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# PowerShell script to launch Chrome with all available profiles and show emails/status

# (Rest deines Skripts folgt hier)


# PowerShell script to launch Chrome with all available profiles and show emails/status

# Define Chrome path
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"

# Alternative paths in case Chrome is installed elsewhere
if (!(Test-Path $chromePath)) {
    $chromePath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
}

if (!(Test-Path $chromePath)) {
    Write-Host "Chrome not found! Please adjust the path." -ForegroundColor Red
    exit 1
}

# Chrome user data directory
$userDataPath = "$env:LOCALAPPDATA\Google\Chrome\User Data"

if (!(Test-Path $userDataPath)) {
    Write-Host "Chrome user data directory not found!" -ForegroundColor Red
    exit 1
}

# Find all profiles
$profiles = @()
$profileDirs = Get-ChildItem -Path $userDataPath -Directory | Where-Object {
    $_.Name -match "^(Default|Profile \d+)$"
}

foreach ($profileDir in $profileDirs) {
    $prefsFile = Join-Path $profileDir.FullName "Preferences"
    if (Test-Path $prefsFile) {
        try {
            $prefs = Get-Content $prefsFile -Raw | ConvertFrom-Json
            $profileName = if ($prefs.profile.name) { $prefs.profile.name } else { $profileDir.Name }

            $email = $null
            if ($prefs.account_info -and $prefs.account_info.Count -gt 0) {
                $email = $prefs.account_info[0].email
            }

            $profiles += [PSCustomObject]@{
                Directory = $profileDir.Name
                Name = $profileName
                Email = $email
                Path = $profileDir.FullName
            }
        }
        catch {
            # Fallback if Preferences cannot be read
            $profiles += [PSCustomObject]@{
                Directory = $profileDir.Name
                Name = $profileDir.Name
                Email = ""
                Path = $profileDir.FullName
            }
        }
    }
}

if ($profiles.Count -eq 0) {
    Write-Host "No Chrome profiles found!" -ForegroundColor Yellow
    exit 1
}

# Show found profiles
Write-Host "`nDetected Chrome profiles:" -ForegroundColor Green
foreach ($profile in $profiles) {
    $emailDisplay = if ($profile.Email) { $profile.Email } else { "No email found" }
    Write-Host "  → $($profile.Name) [$($profile.Directory)] - $emailDisplay" -ForegroundColor Cyan
}

Write-Host "`nLaunching Chrome with all profiles..." -ForegroundColor Green

# Launch all profiles
foreach ($profile in $profiles) {
    Write-Host "Launching: $($profile.Name) ..." -ForegroundColor Yellow

    $arguments = @(
        "--profile-directory=`"$($profile.Directory)`""
        "--new-window"
    )

    Start-Process -FilePath $chromePath -ArgumentList $arguments

    Write-Host "→ Launched: $($profile.Name)" -ForegroundColor DarkGreen
    Start-Sleep -Milliseconds 500  # Short pause between launches
}

Write-Host "`n✅ All profiles have been launched successfully!" -ForegroundColor Green
