# Scripting-for-Server-Security-Part-1

Documentation
System Requirements
Bash shell

Core utilities (grep, awk, find, stat, md5sum)

lastb command (for failed login attempts)

mailutils (optional, for email alerts)

Assumptions and Justifications
Concerning login behavior: Midnight-6am logins, root logins, and multiple failures are flagged as these patterns often indicate unauthorized access attempts.

Critical directories: /etc (configuration files), /var/log (log files that might be altered to hide intrusions), and system binaries directories are monitored as changes here could indicate system compromise.

Hidden files and root executables: These are common targets for attackers to hide backdoors or maintain persistence, so monitoring them is crucial.

Additional Security Scripts Considerations
Other useful security scripts might include:

File integrity monitoring for web directories to detect defacement

Port scanner to detect unexpected open ports

User account monitor to detect unauthorized new accounts

Cron jobs are ideal for these scripts as they provide regular, automated monitoring without manual intervention. However, care must be taken to:

Not overload the system with frequent scans

Secure the script output files

Rotate log files to prevent disk space issues

Sources:

Binnie, C. (2016). Linux server security: Hack and defend. Wiley. https://www.kufunda.net/publicdocs/Linux%20Server%20security%20hack%20and%20defend%20(Binnie,%20Chris).pdf  

Bauer, M. D. (2015). Linux server security (2nd ed.). O'Reilly Media.https://www.oreilly.com/library/view/linux-server-security/0596006705/ 

Nemeth, E., Snyder, G., Hein, T. R., & Whaley, B. (2017). UNIX and Linux system administration handbook (5th ed.). Addison-Wesley. https://www.usenix.org/system/files/login/issues/login_fall18_issue.pdf#page=61 
