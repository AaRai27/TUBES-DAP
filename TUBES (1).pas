program tubes;
uses crt;

const nmax = 100;

type infodokter = record
				id: char;	{id dokter}
				jenis: string;	{jenis bidang dokter}
				lokasi: integer;	{lokasi nomor dokter}
				status: string;	{BPJS atau non-BPJS}
				jenispenyakit: string;	{jenis penyakit pasien}
			  end;

type infopasien = record
				nama: string;
				jenispenyakit: string;	{PENYAKIT PASIEN}
				status: string;		{MENGGUNAKAN BPJS ATAU non-BPJS}
				dokid: char;	{ID DOKTER YANG MELAYANI PASIEN}
				jenisdok: string;	{JENIS DOKTER}
				lokasidok: integer;	{LOKASI DOKTER SI PASIEN}
				statusdok: string;		{MENERIMA BPJS ATAU non-BPJS}
				biayatindakan: integer;	{BIAYA TINDAKAN PASIEN YANG DITANGGUNG BPJS }
				biayaobat: integer;		{BIAYA OBAT PASIEN YANG DITANGGUNG BPJS}
				ratarata: real;		{RATA-RATA PERSENTASE BIAYA TINDAKAN YANG DITANGGUNG BPJS}
				total: integer;		{TOTAL LAYANAN PASIEN YANG DITANGGUNG BPJS}
			  end;

type infotanggungan = record
				jenispenyakit: string;
				biayatindakan: integer;
				biayaobat: integer;
			  end;

type arraydokter = array[1..nmax] of infodokter;
type arraypasien = array[1..nmax] of infopasien;
type arraytanggungan = array[1..nmax] of infotanggungan;

var	
	pilih : integer; {memilih menu tampilan awal}
	dokter : arraydokter;
	pasien: arraypasien;
	tanggungan : arraytanggungan;
	i,pilihan,banyakpasien,banyakdokter,j: integer;
	dok_id: char;
	jawab: string;

	
{================   M E N U   U T A M A  ===================================================================}
	procedure menu();
	begin
		writeln('=================================================================================================');
		writeln('                           SELAMAT DATANG DI APLIKASI RUMAH SAKIT SEHAT');
		writeln('=================================================================================================');
		writeln('SILAHKAN PILIH MENU YANG INGIN DIBUKA :');
		writeln;
		writeln('1) PENDAFTARAN PASIEN');
		writeln('2) TAMBAH DATA DOKTER');
		writeln('3) CEK DOKTER');
		writeln('4) DAFTAR PASIEN');
		writeln('0) EXIT ');
		writeln;
		writeln('=================================================================================================');
		writeln;
		write('MASUKKAN PILIHAN: ');
	end;




{ =======================   P R O C E D U R E    N O M O R    S A T U ===================================================}

	function ratapersentase(pasien:arraypasien; banyakpasien:integer):real;		{W  A  J  I  B   4 }
	begin
		ratapersentase:= (pasien[j].biayatindakan + pasien[j].biayaobat) / 2;
	end;

	function totaltanggungan(tanggungan: arraytanggungan): integer;				{W  A  J  I  B   3 }
	begin
		totaltanggungan:= pasien[j].biayatindakan + pasien[j].biayaobat;
	end;


	procedure untukpasien(var pasien: arraypasien);
	begin
		writeln('NAMA PASIEN: ');
		readln(pasien[j].nama);
		writeln('KELUHAN PENYAKIT: ');	{jenis/ kategori dokter berdasarkan keluhan sakit (umum,anak,kulit,dll.)}
		readln(pasien[j].jenispenyakit);
		writeln('BPJS / non-BPJS: ');
		readln(pasien[j].status);
	end;

	procedure cekdatadokterBPJS(var pasien: arraypasien; var tanggungan: arraytanggungan; var dokter: arraydokter);			{W  A  J  I  B   3 }
	var	
		i: integer;
		
	begin
		i:=1;
		while((i<banyakdokter) and (pasien[j].jenispenyakit <> tanggungan[i].jenispenyakit)) do
		begin
			i:=i+1;
		end;
		if ((pasien[j].jenispenyakit = tanggungan[i].jenispenyakit) and (pasien[j].status = dokter[i].status)) then
			begin
					write('ID DOKTER : ');
					writeln(dokter[i].id);
					pasien[j].dokid := dokter[i].id;
					write('JENIS DOKTER : ');
					writeln(dokter[i].jenis);
					pasien[j].jenisdok:= dokter[i].jenis;
					write('LOKASI DOKTER: ');
					writeln(dokter[i].lokasi);
					pasien[j].lokasidok:= dokter[i].lokasi;
					write('STATUS DOKTER : ');
					writeln(dokter[i].status);
					pasien[j].statusdok := dokter[i].status;
					write('JENIS PENYAKIT: ');
					writeln(tanggungan[i].jenispenyakit);
					write('BIAYA TINDAKAN : ');
					writeln(tanggungan[i].biayatindakan,' (ditanggung BPJS)');
					pasien[j].biayatindakan := tanggungan[i].biayatindakan;
					write('BIAYA OBAT : ');
					writeln(tanggungan[i].biayaobat,' (ditanggung BPJS)');
					pasien[j].biayaobat := tanggungan[i].biayaobat;
					totaltanggungan(tanggungan);
					pasien[j].total:= totaltanggungan(tanggungan);
					writeln('TOTAL LAYANAN YANG DITANGGUNG BPJS : ',pasien[j].total);
			end
	 	else if ((pasien[j].jenispenyakit <> tanggungan[i].jenispenyakit) or (pasien[j].status <> dokter[i].status)) then
	 		begin
	   			writeln('DOKTER TIDAK TERSEDIA');
	   		end;
	end;

	procedure totalpasien(var pasien: arraypasien; var tanggungan: arraytanggungan; var dokter: arraydokter);
	var
		i: integer;
	begin
		i:=1;
		while((i<banyakdokter) and (pasien[j].jenispenyakit <> tanggungan[i].jenispenyakit)) do
			begin
				i:=i+1;
			end;
		if ((pasien[j].jenispenyakit = tanggungan[i].jenispenyakit) and (pasien[j].status = dokter[i].status)) then
			begin
				ratapersentase(pasien,banyakpasien);
				pasien[j].ratarata := ratapersentase(pasien,banyakpasien);
				writeln('RATA-RATA PELAYANAN YANG DITANGGUNG BPJS: ');
				writeln(pasien[j].ratarata:0:2);
				j:=j+1;
				banyakpasien:=banyakpasien+1;
			end
		else if ((pasien[j].jenispenyakit <> tanggungan[i].jenispenyakit) and (pasien[j].status <> dokter[i].status)) then
			begin
				j:= j+0;
				banyakpasien:= banyakpasien+0;
			end;
	end;

{ =======================   P R O C E D U R E    N O M O R    D U A =================================================}
	procedure lanjut(var pilihan: integer);
	begin
		writeln('1) ISI DATA DOKTER');
		writeln('0) KEMBALI');
		writeln;
		writeln('=================================================================================================');
		writeln;
		writeln('PILIHAN: ');
		readln(pilihan);
		clrscr;
	end;

	procedure datadokter(var dokter: arraydokter; i: integer);				{W  A  J  I  B  1 }
	begin
		writeln('DATA DOKTER :');
		writeln;
		write('ID DOKTER : ');
		readln( dokter[i].id);
		write('JENIS DOKTER : ');
		readln(dokter[i].jenis);
		write('LOKASI DOKTER : ');
		readln(dokter[i].lokasi);
		write('STATUS DOKTER (BPJS/non-BPJS): ');
		readln(dokter[i].status);
		writeln('==================================================');
	end;

	procedure datatanggungan(var tanggungan: arraytanggungan; i: integer);		{W  A  J  I  B  1 }
	begin
		writeln('DATA TANGGUNGAN :');
		writeln;
		write('JENIS PENYAKIT: ');
		readln(tanggungan[i].jenispenyakit);
		write('BIAYA TINDAKAN (ditanggung BPJS): ');
		readln(tanggungan[i].biayatindakan);
		write('BIAYA OBAT (ditanggung BPJS): ');
		readln(tanggungan[i].biayaobat);
		writeln('==================================================');
		clrscr;
	end;

{=============== P R O C E D U R E    N O M O R     T I G A ========================================================}
	
	procedure cekdatadokter(var tanggungan: arraytanggungan; var dokter: arraydokter; dok_id: char);		{W  A  J  I  B   2 }
	var
		i: integer;
	begin
		i:=1;
		while (i < banyakdokter) and (dokter[i].id <> dok_id) do
			begin
				i:= i+1;
			end;
		if dokter[i].id = dok_id then
		begin	
			write('JENIS DOKTER : ');
			writeln(dokter[i].jenis);
			write('LOKASI DOKTER : ');
			writeln(dokter[i].lokasi);
			write('STATUS DOKTER : ');
			writeln(dokter[i].status);
			write('JENIS PENYAKIT: ');
			writeln(tanggungan[i].jenispenyakit);
			write('BIAYA TINDAKAN : ');
			writeln(tanggungan[i].biayatindakan,' (ditanggung BPJS)');
			write('BIAYA OBAT : ');
			writeln(tanggungan[i].biayaobat,' (ditanggung BPJS)');
			writeln;
		end;
	end;

{=============== P R O C E D U R E    N O M O R    E M P A T ========================================================}
	
	procedure datapasien(var pasien: arraypasien);
	var
		j: integer;
	begin
		j:= 1;
		repeat 
		begin
			writeln('NAMA PASIEN: ');
			writeln(pasien[j].nama);
			writeln('KELUHAN PENYAKIT: ');	{jenis/ kategori dokter berdasarkan keluhan sakit (umum,anak,kulit,dll.)}
			writeln(pasien[j].jenispenyakit);
			writeln('BPJS / non-BPJS: ');
			writeln(pasien[j].status);
			writeln; 
			writeln('DITANGANI OLEH DOKTER: '); 
			writeln; 
			write('ID DOKTER : '); 
			writeln(pasien[j].dokid); 
			write('JENIS DOKTER : '); 
			writeln(pasien[j].jenisdok); 
			write('LOKASI DOKTER: '); 
			writeln(pasien[j].lokasidok);
			write('STATUS DOKTER : ');
			writeln(pasien[j].statusdok);
			write('BIAYA TINDAKAN : ');
			writeln(pasien[j].biayatindakan,' (ditanggung BPJS)');
			write('BIAYA OBAT : ');
			writeln(pasien[j].biayaobat,' (ditanggung BPJS)');
			writeln('TOTAL LAYANAN YANG DITANGGUNG BPJS : ',pasien[j].total);
			writeln;
			writeln('RATA-RATA PELAYANAN YANG DITANGGUNG BPJS: ');
			writeln(pasien[j].ratarata:0:2);
			j:=j+1;
			writeln;
			writeln('=================================================================================================');
			writeln;
			writeln('NEXT: ENTER');
			readln;
		end;
		until (j > banyakpasien);
	end;

{=============== P R O C E D U R E   W A J I B    L I M A ========================================================}

	procedure urut(var pasien: arraypasien; banyakpasien: integer);			{W  A  J  I  B  5 }
	var 
		i: integer;
		j: integer;
		imaks: integer;
		temp: integer;
	begin
		for i:= banyakpasien downto 2 do
			begin
				imaks:= 1;
				for j:= 2 to i do
				begin
					if (pasien[j].total > pasien[imaks].total) then
						imaks:= j;
				end;

				temp:= pasien[j].total;
				pasien[j].total:= pasien[imaks].total;
				pasien[imaks].total := temp;
			end;

	end;

{ ==================  P R O G R A M    U T A M A  =========== P R O G R A M    U T A M A ==========================}
begin
	i:=1;
	banyakdokter:=0;
	banyakpasien:=0;
	j:=1;
	repeat
		begin
			clrscr;
			menu();
			readln(pilih);
			clrscr;
			case pilih of

				1 : begin
					repeat
						begin
							writeln('MENDAFTAR ?');
							readln(jawab); 
							clrscr;
							if (jawab = 'ya') then
							begin
								untukpasien(pasien);
								writeln;
								cekdatadokterBPJS(pasien,tanggungan,dokter);
								totalpasien(pasien,tanggungan,dokter);
								writeln;
								readln;
								clrscr;
							end;
						end;
					until (jawab = 'tidak');
					end;	

				2 : begin
					repeat
						begin
						lanjut(pilihan);
						if (pilihan = 0) then
							begin
								menu();
							end
						else if (pilihan = 1) then
							begin 
								datadokter(dokter,i);
								datatanggungan(tanggungan,i);
								i:=i+1;
								banyakdokter:=banyakdokter+1;
							end;
						clrscr;
						end;
					until(pilihan = 0);
					end;

				3 : begin
						writeln('======================  C A R  I    D O K T E R     P R A K T E K  =====================');
						writeln;
						writeln('ID DOKTER: ');
						readln(dok_id);
						cekdatadokter(tanggungan,dokter,dok_id);
						writeln;
						writeln ('tekan enter untuk kembali');
						readln;
					end;

				4 : begin
						if ((banyakpasien = 0))  then
							begin
								writeln('BELUM ADA PASIEN');
							end
						else
							begin
								datapasien(pasien);
							end;
					end;
			end;
		end;
	until (pilih = 0); 
	writeln('DATA PERSENTASE BIAYA TINDAKAN YANG DITANGGUNG BPJS: ');
	urut(pasien,banyakpasien);
	for j:= 1 to banyakpasien do
	begin
		writeln(pasien[j].total);
	end;
	readln;
end.