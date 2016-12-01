program LindaMultiplication;
{multiply two 3x3 matrices A and B - One Worker}

process initandprint;
var	c, i, j, k: integer; 
begin
  {array A}
  postnote('a',11,1); postnote('a',12,2); postnote('a',13,3);
  postnote('a',21,4); postnote('a',22,5); postnote('a',23,6);
  postnote('a',31,7); postnote('a',32,8); postnote('a',33,9);

  {array B}
  postnote('b',11,1); postnote('b',12,0); postnote('b',13,2);
  postnote('b',21,1); postnote('b',22,2); postnote('b',23,1);
  postnote('b',31,1); postnote('b',32,1); postnote('b',33,1);

  postnote('N',1); {Next job counter}
  
  for i:= 1 to 3 do for j:=1 to 3 do begin k:=i*10+j; removenote('c',k,c); writeln('c',k,'=',c); end;
end;

process worker;
var element, row, col, n, r, c, a, b, v, r1, c1 :integer;
begin
  while true do
     begin
        removenote('N',element); 
        postnote('N',element+1);
        if element > 3*3 then suspend;
        row:=(element-1)div 3+1; {row number}
        col:=(element-1)mod 3+1; {column number}
        v:=0;
        for n:=1 to 3 do
            begin
              r:=row*10+n; c:=n*10+col; 
              r1:=0; c1:=0;
              repeat removenote('a',r1,a); postnote('a',r1,a) until r1 = r;
              repeat removenote('b',c1,b); postnote('b',c1,b) until c1 = c;
              v:=v+a*b; 
            end;       
        n:= row*10+col; postnote('c',n,v);

    end;
end;
begin
  cobegin initandprint; worker; coend;
end.
