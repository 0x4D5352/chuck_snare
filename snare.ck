// This is where the different parts of the snare will come together.
Event e;
Transient transient;
Fundamental fundamental;
Tail tail;
Gain g => Dyno d => dac;
dac => WvOut w => blackhole;
me.dir() + "test.wav" => w.wavFilename;
0 => int flam; // Set to 1 for flam

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
	else if (s == "flam")
	{
		fundamental.flam();
	}
	else
	{
		<<<"Invalid!">>>;
	}
}

transient.connect(g);
fundamental.connect(g);
tail.connect(g);
d.limit();
d.thresh(0.9);
1.2 => g.gain;


spork ~ snareEvent(e, "tail");
spork ~ snareEvent(e, "transient");
spork ~ snareEvent(e, "fundamental");
if(flam) spork ~ snareEvent(e, "flam");
10::ms => now;
e.broadcast();
1::second => now;
w.closeFile;
10::ms => now;

// N2S: Currently, this does not work. Figure out how to make it work.
/*
HidMsg msg;
Hid hid;
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