//Snare Transient Generator
class Transient
{
	Noise n => Envelope e => Gain g => dac;
	// SinOsc s => e; // IMPLEMENT ME

	// Init Values
	5::ms => clickTime;
	0.9 => clickGain;

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
		1 => e.keyOff;
		30::ms => now;
	}
}