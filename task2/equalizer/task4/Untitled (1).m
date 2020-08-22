fileName='welcome.wav';
[y, fs, nbits]=wavread(fileName);
fprintf('Information of the sound file "%s":\n', fileName);
fprintf('Duration = %g seconds\n', length(y)/fs);
fprintf('Sampling rate = %g samples/second\n', fs);
fprintf('Bit resolution = %g bits/sample\n', nbits);
Information of the sound file "welcome.wav";
Duration = 1.45134 sec;
Sampling rate = 11025 samples/second
Bit resolution = 8 bits/sample