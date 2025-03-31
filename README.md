# Scripting for Server Security - Part 1

## Documentation

### System Requirements
To run these security scripts, ensure your system meets the following requirements:

- **Bash shell**
- **Core utilities** (`grep`, `awk`, `find`, `stat`, `md5sum`)
- **`lastb` command** (for failed login attempts)
- **`mailutils`** *(optional, for email alerts)*

---

## Assumptions and Justifications

### Login Behavior Monitoring
The script flags the following login patterns, which may indicate unauthorized access attempts:

- **Logins between midnight and 6 AM**
- **Root logins**
- **Multiple failed login attempts**

### Critical Directory Monitoring
These directories are monitored for unauthorized changes:

- `/etc` *(configuration files)*
- `/var/log` *(log files that may be altered to hide intrusions)*
- System binaries directories *(modifications may indicate system compromise)*

### Hidden Files & Root Executables
Monitoring these is crucial because attackers often hide backdoors or maintain persistence using:

- **Hidden files**
- **Root-owned executables**

---

## Additional Security Script Considerations
Other useful security scripts may include:

- **File integrity monitoring** for web directories to detect defacement
- **Port scanner** to detect unexpected open ports
- **User account monitoring** to detect unauthorized new accounts

### Best Practices
When implementing security scripts, keep the following in mind:

- **Use cron jobs** for regular, automated monitoring
- **Avoid excessive system load** by scheduling scans appropriately
- **Secure script output files** to prevent unauthorized access
- **Rotate log files** to prevent disk space issues

---

## Sources

- Binnie, C. (2016). *Linux Server Security: Hack and Defend.* Wiley. [Read here](https://www.kufunda.net/publicdocs/Linux%20Server%20security%20hack%20and%20defend%20(Binnie,%20Chris).pdf)
- Bauer, M. D. (2015). *Linux Server Security (2nd ed.).* O'Reilly Media. [Read here](https://www.oreilly.com/library/view/linux-server-security/0596006705/)
- Nemeth, E., Snyder, G., Hein, T. R., & Whaley, B. (2017). *UNIX and Linux System Administration Handbook (5th ed.).* Addison-Wesley. [Read here](https://www.usenix.org/system/files/login/issues/login_fall18_issue.pdf#page=61)

---


