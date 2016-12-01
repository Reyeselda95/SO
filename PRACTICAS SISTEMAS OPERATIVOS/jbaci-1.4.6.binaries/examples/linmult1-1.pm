program LindaMultiplication;
{multiply two 3x3 matrices A and B - 1 Worker}

var a,b :array[1..3,1..3] of integer;

process initandprint;
var	c, i, j, k: integer; 
begin
  {array A}
  a[1,1]:=1; a[1,2]:=2; a[1,3]:=3;
  a[2,1]:=4; a[2,2]:=5; a[2,3]:=6;
  a[3,1]:=7; a[3,2]:=8; a[3,3]:=9;
  
  {array B}
  b[1,1]:=1; b[1,2]:=0; b[1,3]:=2;
  b[2,1]:=1; b[2,2]:=2; b[2,3]:=1;
  b[3,1]:=1; b[3,2]:=1; b[3,3]:=1;

  {post worker notes}
  postnote('w',1,1); postnote('w',1,2); postnote('w',1,3);
  postnote('w',2,1); postnote('w',2,2); postnote('w',2,3);
  postnote('w',3,1); postnote('w',3,2); postnote('w',3,3);

  postnote('N',1); {Next job counter}
  
  for i:= 1 to 3 do for j:=1 to 3 do begin k:=i*10+j; removenote('c',k,c); writeln('c',k,'=',c); end;
end;

process worker;
var element, row, col, r, v  :integer;
begin
  while true do
     begin
        removenote('N',element); 
        postnote('N',element+1);
        if element > 3*3 then suspend;
        removenote('w',row,col);
        v:=0;
        for r:=1 to 3 do v:=v+a[row,r]*b[r,col]; 
        r:= row*10+col; postnote('c',r,v);
     end;
end;
begin
  cobegin initandprint; worker; coend;
end.
