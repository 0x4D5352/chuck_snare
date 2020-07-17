// This is where the different parts of the snare will come together.
Hid hid;
HidMsg msg;
Event e;
Transient transient;
Fundamental fundamental;
Tail tail;
dac => WvOut w => blackhole;
me.dir() + "test.wav" => w.wavFilename;

fun void snareEvent(Event e, string s)
{
	if(s == "tail")
	{
		tail.tailSplash();
	}
	else if (s == "transient")
	{
		transient.strikeBeater();
	}
	else if (s == "fundamental")
	{
		fundamental.strikeSnare();
	}
	else
	{
		<<<"Invalid!">>>;
	}
}

spork ~ snareEvent(e, "tail");
spork ~ snareEvent(e, "transient");
spork ~ snareEvent(e, "fundamental");
10::ms => now;
e.broadcast();
1::second => now;
w.closeFile;
10::ms => now;

// N2S: Currently, this does not work. Figure out how to make it work.
/*
1 => int device; // if your keyboard does not work, change this number to 0, then 2, 3, etc. until it works!
if(hid.openKeyboard(device) == false) me.exit();
<<<"keyboard:", hid.name(), "ready!">>>;
while(1)
{
	hid => now;

	while(hid.recv(msg))
	{
		if(msg.isButtonDown())
		{
			<<<"DOWN", msg.ascii>>>;
			transient.strikeBeater();
			fundamental.strikeSnare();
			tail.tailSplash();
			3::second => now;
		}
		else
		{
			<<<"UP", msg.ascii>>>;
		}
	}
}
*/