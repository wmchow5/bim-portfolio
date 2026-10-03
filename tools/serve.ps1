# Local preview of the portfolio site in docs/ at http://localhost:8765 (or pass a port)
$root = Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) "..\docs"
$l = New-Object System.Net.HttpListener
$port = if ($args.Count -gt 0) { $args[0] } else { 8765 }
$l.Prefixes.Add("http://localhost:$port/")
$l.Start()
$types = @{".html"="text/html; charset=utf-8";".png"="image/png";".css"="text/css";".js"="text/javascript";".pdf"="application/pdf"}
while ($l.IsListening) {
  $c = $l.GetContext()
  $p = [Uri]::UnescapeDataString($c.Request.Url.AbsolutePath.TrimStart('/'))
  if ($p -eq "") { $p = "index.html" }
  if ($p -eq "mobile-frame.html") { $f = Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) "mobile-frame.html" } else { $f = Join-Path $root $p }
  if (Test-Path $f -PathType Leaf) {
    $b = [IO.File]::ReadAllBytes($f); $ext = [IO.Path]::GetExtension($f)
    if ($types.ContainsKey($ext)) { $c.Response.ContentType = $types[$ext] }
  } else { $c.Response.StatusCode = 404; $b = [Text.Encoding]::UTF8.GetBytes("not found") }
  $c.Response.OutputStream.Write($b, 0, $b.Length); $c.Response.Close()
}