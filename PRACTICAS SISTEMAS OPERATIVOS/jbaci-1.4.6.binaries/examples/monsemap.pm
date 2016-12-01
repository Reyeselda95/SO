program semaphore_emulation;

MONITOR monSemaphore;
VAR
   semvalue : INTEGER;
   notbusy : CONDITION;
PROCEDURE monP;
BEGIN
   IF (semvalue = 0) THEN WAITC(notbusy);
   semvalue := semvalue -1;
END;
PROCEDURE monV;
BEGIN
   semvalue := semvalue + 1;
   SIGNALC(notbusy);
END;
BEGIN { initialization code }
   semvalue := 1;
END; 

procedure p1;
begin
   while true do
      begin
        monP;
        writeln('p1 is in critical section');
        monV;
      end;
end;

procedure p2;
begin
   while true do
      begin
        monP;
        writeln('p2 is in critical section');
        monV;
      end;
end;

begin {main}
  cobegin p1;p2 coend;
end.