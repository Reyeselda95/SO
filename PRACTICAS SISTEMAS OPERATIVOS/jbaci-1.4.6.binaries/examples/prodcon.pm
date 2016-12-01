program producer_consumer;
const n=5; k=4;{k is n-1}

monitor producer_consumer_monitor;
var b: array[0..k] of integer;
    in_ptr, out_ptr: integer;
    count: integer;
    not_full, not_empty: condition;
    m: integer;
procedure append(i: integer);
begin
   if count = n then waitc(not_full);
   count:=count+1;
   b[in_ptr]:= i; 
   in_ptr:= (in_ptr+1) mod n; for m:=0 to k do writeln('append:', b[m],' in_ptr',in_ptr);
   signalc(not_empty);
end;
procedure take(i: integer);
begin
   if count = 0 then waitc(not_empty);
   count:=count-1;
   i:= b[out_ptr]; writeln('i',i);
   out_ptr:= (out_ptr+1) mod n; for m:=0 to k do writeln('take:', b[m],' out_ptr',out_ptr);
   signalc(not_full);
end;
begin
   in_ptr:=0; out_ptr:=0; for count:= 0 to k do b[count]:=-1; count:=0;
end;

procedure producer;
var i: integer;
begin
  while true do
     begin
       i:=random(10); writeln('value produced =',i);
       append(i);
     end;
end;
procedure consumer;
var i: integer;
begin
  while true do
     begin
       take(i);
       writeln('i =',i);
     end;
end;
begin {main}
  cobegin producer; consumer coend;
end.

















