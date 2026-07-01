# 1. Initialize git if you haven't (Nix Flakes require tracked files to recognize them)
git init && git add .

# 2. Drop into your isolated sandbox environment
nix develop

# 3. Fire up your experimental editor!
nv-sandbox
