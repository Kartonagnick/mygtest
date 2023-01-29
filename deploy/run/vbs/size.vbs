
function prepare(data)
  long_space = Chr(160)
 'wscript.echo "src = " & data

  set re = new RegExp
  re.Pattern = "(\s|" & long_space & "|')*"
  re.Global = true
  data = re.Replace(data, "")
 'wscript.echo "[0] data = " & data

  re.Pattern = "\(.*"
  re.Global = true
  data = re.Replace(data, "")
 'wscript.echo "[1] data = " & data

  prepare = data
end function

function fromGBytes(gbytes)
  fromGBytes = gbytes & " 0 0 0"
end function

function fromMBytes(mbytes)
  gbytes = Fix(mbytes / 1024)
  g_aligment = gbytes * 1024
  mbytes = mbytes - g_aligment

  fromMBytes = gbytes & " " & mbytes & " 0 0"
end function

function fromKBytes(kbytes)
  gbytes = Fix(kbytes / 1048576)
  g_aligment = gbytes * 1048576
  kbytes = kbytes - g_aligment

  mbytes = Fix(kbytes / 1024)
  m_aligment = mbytes * 1024
  kbytes = kbytes - m_aligment

  fromKBytes = gbytes & " " & mbytes & " " & kbytes & " 0"
end function

function fromBytes(bytes)
  gbytes = Fix(bytes / 1073741824)
  g_aligment = gbytes * 1073741824
  bytes = bytes - g_aligment

  mbytes = Fix(bytes / 1048576)
  m_aligment = mbytes * 1048576
  bytes = bytes - m_aligment

  kbytes = Fix(bytes/1024 )
  k_aligment = kbytes * 1024

  bytes = bytes - k_aligment

  fromBytes = gbytes & " " & mbytes & " " & kbytes & " " & bytes
end function

function main
  set objArgs = WScript.Arguments

  if objArgs.Count = 0 then
    wscript.echo "0 0 0 0"
    wscript.quit 0
  end if

  size = prepare(objArgs(0))

  if objArgs.Count = 1 then
   dsc = fromBytes(size)

  elseif objArgs(1) = "b" then
   dsc = fromBytes(size)

  elseif objArgs(1) = "kb" then
   dsc = fromKBytes(size)

  elseif objArgs(1) = "mb" then
   dsc = fromMBytes(size)

  elseif objArgs(1) = "gb" then
   dsc = fromGBytes(size)

  end if

  wscript.echo dsc
end function 

main()
