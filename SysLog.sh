#!/bin/bash
#SysLog.sh

#Forensic data collection
forensic_collection() {
    mkdir -p Forensics
    uname -a > Forensics/SystemInfo.txt  #System info
    cut -d: -f1 /etc/passwd > Forensics/UserInfo.txt  # User list
    ps aux > Forensics/Processes.txt  #Process list
    ss -tulwn > Forensics/NetworkConnections.txt  #Net connections
    if [ -f /var/log/syslog ]; then
        tail -n 100 /var/log/syslog > Forensics/EventLogs.txt
    elif [ -f /var/log/messages ]; then
        tail -n 100 /var/log/messages > Forensics/EventLogs.txt
    else
        echo "No syslog found" > Forensics/EventLogs.txt
    fi
    echo "Forensic saved to Forensics"
}

#Syslog analysis
syslog_analysis() {
    mkdir -p SecurityLogs
    currentDate=$(date +%Y%m%d)
    if [ -f /var/log/auth.log ]; then
        authlog="/var/log/auth.log"
    elif [ -f /var/log/secure ]; then
        authlog="/var/log/secure"
    else
        authlog=""
    fi
    if [ -n "$authlog" ]; then
        grep "Accepted" "$authlog" > SecurityLogs/"${currentDate}-SecurityLogs.log"
        count=$(grep -c "Accepted" "$authlog")
    else
        echo "No auth log" > SecurityLogs/"${currentDate}-SecurityLogs.log"
        count=0
    fi
    echo "Successful logins: $count" > SecurityLogs/LoginSummary.txt
    echo "Syslog analysis done"
}

#Security report generation
security_report() {
    mkdir -p SecurityLogs
    report_file="SecurityLogs/AnalysisReport.html"
    cat <<EOF > "$report_file"
<!DOCTYPE html>
<html>
<head>
    <title>Security Report</title>
</head>
<body>
    <h1>Security Report</h1>
    <table border="1">
    <tr><th>Event</th><th>Details</th></tr>
EOF
    if [ -f SecurityLogs/LoginSummary.txt ]; then
        summary=$(cat SecurityLogs/LoginSummary.txt)
        echo "<tr><td>Logins</td><td>$summary</td></tr>" >> "$report_file"
    fi
    if [ -f /var/log/syslog ]; then
        tail_log=$(tail -n 10 /var/log/syslog)
        echo "<tr><td>Syslog tail</td><td><pre>$tail_log</pre></td></tr>" >> "$report_file"
    elif [ -f /var/log/messages ]; then
        tail_log=$(tail -n 10 /var/log/messages)
        echo "<tr><td>Syslog tail</td><td><pre>$tail_log</pre></td></tr>" >> "$report_file"
    fi
    cat <<EOF >> "$report_file"
    </table>
</body>
</html>
EOF
    echo "Report generated at $report_file"
}

#Main
case "$1" in
    1)
        forensic_collection
        ;;
    2)
        forensic_collection
        syslog_analysis
        ;;
    *)
        forensic_collection
        syslog_analysis
        security_report
        ;;
esac

echo "Tasks completed."
