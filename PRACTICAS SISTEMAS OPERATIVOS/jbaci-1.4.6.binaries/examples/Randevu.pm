{ m1_q3_93.cp
  Ceng 534 Operating Systems Midterm 1 Question 3  ...  November 30, 1993

  Consider three processes p1, p2, and p3. How you implement a 3-way rendezvous
  to synchronize these processes using the concurrent Pascal kit of Ben-Ari.
  
}
program synchronization;

const  n = 3;
var 
    s         : array[1..n] of semaphore;
    screen    : semaphore;  {for the screen}
    i         : integer;

procedure p(i :integer);
var j,k,r :integer;
begin
   while true do
      begin
        r:= random(100);
        wait(screen); 
           writeln('Process ',i,' is executing for ',r,' units'); 
        signal(screen);
        k:=0;  for j:= 1 to r do k:= k+ 1;   
        wait(screen); 
           writeln('Process ',i,' is waiting for others ..'); 
        signal(screen);

        for j:= 1 to n do if j <> i then signal(s[j]);
        for j:= 1 to n-1 do wait(s[i]);

        wait(screen);
           writeln('Process ',i,' has made the rendezvous ..');
        signal(screen);
    end;
end;

begin {main}
   for i:= 1 to n do initialsem(s[i],0);
   initialsem(screen,1);
   cobegin p(1);p(2);p(3) coend;
end.

