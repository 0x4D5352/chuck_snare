//Snare Transient Generator
public class Transient
{
	Noise n => Envelope e => Gain g;
	Impulse i => g;
	//SinOsc s => e; // IMPLEMENT ME

	// Init Values
	10::ms => dur clickTime;
	0.9 => float clickGain;

	fun void setLength(dur length)
	{
		length => clickTime;
	}

	fun void setGain(float gain)
	{
		gain => clickGain;
	}

	fun void strikeBeater()
	{
		clickGain => g.gain;
		clickTime => e.duration;
		1 => e.keyOff;
		1.0 => i.next;
		30::ms => now;
	}

	fun void connect(UGen ugen)
	{
		g => ugen;
	}
}