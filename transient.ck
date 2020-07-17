//Snare Transient Generator
public class Transient
{
	Noise n => Envelope e => Gain g => dac;
	// SinOsc s => e; // IMPLEMENT ME

	// Init Values
	5::ms => dur clickTime;
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
		30::ms => now;
	}
}