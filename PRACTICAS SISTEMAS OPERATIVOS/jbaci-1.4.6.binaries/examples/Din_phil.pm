{ CEng 534 .. Midterm 2 .. 6 January 1988 .. m2_qx_88.cp 
  Solution of dining philosophers problem. In the solution a philosopher
  returns the left fork if right fork is not available at that time.
}
program m2_Q1;
var fork  : array[0..4] of semaphore;
    finuse: array[0..4] of boolean;
    i     : integer;
    mutex : semaphore:=1;

procedure think; var i : integer; begin for i:= 1 to random(100) do end;
procedure eat; var i : integer; begin for i:= 1 to random(50) do end;

procedure ph(i:integer);
var j     : integer;
    flag  : boolean;
begin
    j:= (i+1) mod 5; {right fork index} 
    repeat
       	think;
       
	flag:= true;
  	while flag do 
          begin
             	wait(fork[i]); {pick left fork}
		finuse[i]:=true;
		wait(mutex); writeln('philosopher : ',i,' lifts    left  fork'); signal(mutex);
         	if finuse[j] = true 
                   then begin
         			signal(fork[i]); {right fork in use, return left fork}
				finuse[i]:=false;
				wait(mutex); writeln('philosopher : ',i,' returns  left  fork'); signal(mutex);
         	end 
                   else begin
                        	wait(fork[j]); finuse[j]:= true; flag:= false; {pick right fork}
                        	wait(mutex); 
					write('philosopher : ',i,' picks up right fork'); writeln(' AND STARTS EATING');
				signal(mutex);
                    end;
          end;
       
	eat;
       	signal(fork[i]); signal(fork[j]); {return both forks .. finish eating} 
       	finuse[i]:= false; finuse[j]:=true; 
       	wait(mutex); writeln('philosopher : ',i,' returns  both  forks .. EATING IS OVER!'); signal(mutex); 
   until false;
end;

begin {main}
   for i:= 0 to 4 do initialsem(fork[i],1);   
   for i:= 0 to 4 do finuse[i]:=false; 
   cobegin ph(0); ph(1); ph(2); ph(3); ph(4) coend;
end.

