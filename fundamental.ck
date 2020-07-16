// Snare Fundamental Generator
class Fundamental
{
	SinOsc s => ADSR e => Gain v => dac; //N2S: is there a better way to route this in for post processing?

	//INIT VALUES
	200 => int fundamentalPitch;
	0.9 => float fundamentalGain;
	30::ms => dur holdTime;
	50::ms => dur releaseTime
	0::ms => dur attackTime;
	attackTime => dur decayTime;
	1.0 => sustainLevel;

	fun void setPitch(int pitch)
	{
		pitch => fundamentalPitch; 
	}

	fun void setAHDSR(dur attack, dur hold, dur decay, float sustain, dur release)
	{
		attack => attackTime;
		hold => holdTime;
		decay => decayTime;
		sustain => sustainLevel;
		release => releaseTime;
	}

	fun void setGain(float gain)
	{
		gain => fundamentalGain;
	}

	fun void strikeSnare()
	{
		fundamentalGain => v.gain;
		fundamentalPitch => s.freq;
		(attackTime, decayTime, sustainLevel, releaseTime) => e.set;
		1 => e.keyOn;
		holdTime => now;
		1 => e.keyOff;
		500::ms => now;
	}
}









// w.closeFile;
//dac => WvOut w => blackhole;
//me.dir() + "test.wav" => w.wavFilename;

