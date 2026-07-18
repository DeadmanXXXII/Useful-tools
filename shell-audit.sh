#!/bin/bash

echo "===================================="
echo " Shell Check"
echo " $(date)"
echo "===================================="


run_timeout() {
    timeout 5 "$@" 2>&1 | head -n1
}


echo
echo "[+] System"
echo "----------------"
uname -a
cat /etc/os-release 2>/dev/null | head


echo
echo "[+] Disk Usage"
echo "----------------"
df -h /


echo
echo "[+] Programming Languages"
echo "----------------"


declare -A versions=(
[python]="--version"
[python3]="--version"
[pip]="--version"
[pip3]="--version"
[ruby]="--version"
[gem]="--version"
[go]="version"
[cargo]="--version"
[rustc]="--version"
[node]="--version"
[npm]="--version"
[gcc]="--version"
[make]="--version"
[git]="--version"
)


for t in "${!versions[@]}"; do

printf "%-12s : " "$t"

if command -v "$t" >/dev/null 2>&1; then

case "$t" in

npm)
timeout 3 npm --version 2>&1 | head -n1
;;

java)
timeout 3 java -version 2>&1 | head -n1
;;

*)
timeout 5 "$t" ${versions[$t]} 2>&1 | head -n1
;;

esac

else
echo "missing"
fi

done



echo
echo "[+] Security Tools"
echo "----------------"


tools="
nmap
masscan
rustscan
naabu
nc
netcat
socat
dnsrecon
dnsenum
subfinder
amass
httpx
katana
nuclei
nikto
whatweb
wafw00f
sqlmap
dirb
dirbuster
gobuster
feroxbuster
ffuf
wfuzz
burpsuite
zaproxy
msfconsole
msfvenom
searchsploit
john
hashcat
hydra
medusa
crackmapexec
impacket
responder
bettercap
ettercap
kismet
aircrack-ng
wireshark
tshark
tcpdump
sslscan
testssl
openssl
openvpn
beef-xss
bloodhound
bloodhound-python
evil-winrm
chisel
proxychains
tor
"


for t in $tools
do

printf "%-18s : " "$t"

command -v "$t" 2>/dev/null || echo "missing"

done



echo
echo "[+] Go Tools"
echo "----------------"

echo "GOBIN:"
go env GOPATH 2>/dev/null

echo

if [ -d "$HOME/go/bin" ]; then
ls -lh "$HOME/go/bin"
else
echo "No Go binaries"
fi


echo
echo "[+] Go Cache"
echo "----------------"

du -sh \
$(go env GOPATH 2>/dev/null)/pkg \
$(go env GOCACHE 2>/dev/null) \
2>/dev/null



echo
echo "[+] Python Packages"
echo "----------------"


echo "--- pip ---"
python3 -m pip list 2>/dev/null | head -100


echo
echo "--- pipx ---"

if command -v pipx >/dev/null; then
pipx list
else
echo "pipx missing"
fi


echo
echo "--- Python site packages ---"

python3 - <<EOF
import site
print(site.getsitepackages())
EOF



echo
echo "[+] Ruby Gems"
echo "----------------"

gem list 2>/dev/null | head -100



echo
echo "[+] Cargo Tools"
echo "----------------"

if command -v cargo >/dev/null
then
cargo install --list 2>/dev/null
else
echo "missing"
fi



echo
echo "[+] APT Security Packages"
echo "----------------"

dpkg -l 2>/dev/null | grep -Ei \
"nmap|metasploit|sqlmap|nikto|john|hydra|aircrack|wireshark|kismet|beef|burp|zap|gobuster|impacket|bloodhound|ettercap"



echo
echo "[+] Storage"
echo "----------------"

du -sh \
/root/.cache \
/root/go \
/root/.cargo \
/root/.npm \
/root/.local \
2>/dev/null



echo
echo "===================================="
echo " Audit Complete"
echo "===================================="