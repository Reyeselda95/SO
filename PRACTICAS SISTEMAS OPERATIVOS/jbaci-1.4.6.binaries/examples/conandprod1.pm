program producerandconsumers;

const	n=3;	{3 consumers}
var	s :semaphore:=1;

process producer;
var i: integer := 34;
    c: char;
begin
  while (i < 126) do {characters 34 to 126 are printable characters}
    begin
	wait(s); 
	c:=i; 		{convert value to character - first parameter of postnote is a character!}
	i:=i+1; 	{increment for the next message}
	postnote(c,n) 	{post a message}
    end; 
end;

process consumer;
var c :char; 
    i :integer :=34; 
    j :integer;
begin
  while (i < 126) do
     begin 
	c:=i; removenote(c,j); 			{remove the note}
	j:=j-1; if j <> 0 then postnote(c,j) 	{if not the last process then put note with one less count}
			  else signal(s);
	i:=i+1 					{increment for the next message}
     end;
end;

begin
  cobegin producer; consumer; consumer; consumer; coend;
end.
