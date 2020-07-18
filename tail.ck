// Snare Tail Generator
public class Tail
{
	Noise n => Envelope e => Gain g;

	// Init Values
	0.7 => float tailGain;
	1::ms => dur attackTime;
	185::ms => dur decayTime;

	fun void setGain(float gain)
	{
		gain => tailGain;
	}

	fun void setEnvelope(dur attack, dur decay)
	{
		attack => attackTime;
		decay => decayTime;
	}

	fun void tailSplash()
	{
		tailGain => g.gain;
		attackTime => e.duration;
		1 => e.keyOn;
		attackTime => now;
		decayTime => e.duration;
		1 => e.keyOff;
		decayTime + 10::ms => now;
	}

	fun void connect(UGen ugen)
	{
		g => ugen;
	}
}