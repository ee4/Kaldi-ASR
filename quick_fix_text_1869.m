function quick_fix_text_1869
%This was run Nov 11, 2016, when I found that text had 1869 lines,
%whereas fileids, utt2spk, wav.scp had 1868 lines. This finds and
%removes the extra line from text.

icdir = 'C:\Erik\EMRAI\mnt\new_local\erik\All_PJA_IC6\';
scdir = [icdir 'octave\'];
dadir = [icdir 'data\'];
ddir = [dadir 'train_Hires\'];


fid = fopen([ddir 'fileids']);
fids = fscanf(fid,'%c'); fclose(fid);
fids = uint8(fids);
eols1 = find(fids==10);
U1 = length(eols1), %should equal 1868

fid = fopen([ddir 'text']);
txt = fscanf(fid,'%c'); fclose(fid);
txt = uint8(txt);
eols2 = find(txt==10);
U2 = length(eols2), %should equal 1869

ss1 = 1; ss2 = 1;
for u = 1:U2
  es2 = ss2 + find(txt(ss2:eols2(u))==32,1,'first') - 2;
  if ~isequal(txt(ss2:es2),fids(ss1:eols1(u)-1)), break; end
  ss1 = eols1(u) + 1; ss2 = eols2(u) + 1;
end
u,
