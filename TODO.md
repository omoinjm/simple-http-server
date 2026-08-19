# TODO: finish WSL2 mirrored networking setup

`%UserProfile%\.wslconfig` (`/mnt/c/Users/nhlan/.wslconfig`) has been created with:

```ini
[wsl2]
networkingMode=mirrored
```

This lets other devices on the LAN reach Docker containers running in this WSL2 distro directly, without manual port forwarding. Remaining steps (do these from Windows, not from inside WSL):

- [x] From **Windows PowerShell or cmd** (not a WSL terminal), run `wsl --shutdown`
- [x] Wait ~10 seconds, then reopen the WSL terminal
- [x] Verify mirrored mode took effect: mirrored networking is active — `eth2` shows the real LAN IP `192.168.0.104/24` (previously showed the internal NAT address `172.30.178.250`). Note: it landed on `eth2`, not `eth0` as originally expected — `eth0`/`eth1` are present but down.
- [x] If `docker ps` errors, start the daemon: not needed, daemon was already running
- [x] Run the container: `docker run -d --name simple-http-server -p 8080:8000 -v /home/omoinjm/dev/github/experiments/simple-http-server:/var/www/html simple-http-server:local` — confirmed reachable on both `http://localhost:8080` and `http://192.168.0.104:8080` (HTTP 200)
- [ ] From another laptop on the same network, browse to `http://192.168.0.104:8080`
- [ ] If it doesn't connect, check **Windows Defender Firewall** — allow the port if prompted, or add an inbound rule for the TCP port manually
