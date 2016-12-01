program ReadersWriters;
var	screen :semaphore:=1;

monitor RW;
var	readercount: integer;
	writing: boolean;
	OKtoRead, OKtoWrite: condition;

procedure StartRead;
begin 
	if writing or not empty(OKtoWrite) then waitc(OKtoRead);
	readercount := readercount + 1;
	writeln("Reader count is ", readercount);
	signalc(OKtoRead);
end;

procedure EndRead;
begin
	readercount := readercount - 1;
	if readercount = 0 then signalc(OKtoWrite);
end;

procedure StartWrite;
begin 
	if writing or (readercount <> 0) then waitc(OKtoWrite);
	writing := true;
end;

procedure EndWrite;
begin
	writing := false;
	if empty(OKtoRead) then signalc(OKtoWrite) else signalC(OKtoRead);
end;

begin
	readercount := 0;
	writing := false;
end;

procedure Reader(N: integer);
begin
  while true do
	begin
		StartRead; wait(screen); writeln(N, " is reading"); signal(screen); EndRead;
	end;
end;

procedure Writer(N: integer);
begin
  while true do
	begin
		StartWrite; wait(screen); writeln(N, " is writing"); signal(screen); EndWrite;
	end;
end;

begin
	cobegin
		Reader(1); Reader(2); Reader(3); Reader(4); Reader(5); Reader(6); Reader(7); Reader(8); Reader(9);
		Writer(1); Writer(2); Writer(3); Writer(4); Writer(5); Writer(6); Writer(7); Writer(8);
	coend;
end.

