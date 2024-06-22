{$resource notebook.ico} // первой строкой
 
uses graphabc, abcobjects;

var
  xr: integer := 5;
  yr: integer := 50;
  lis: integer := 1;
  list: Integer := 0;
  rama: PictureAbc;
  plusl, plusk: array[0..28] of PictureABC; 
  bym: string := 'tetrad v lineyky';
  winlog: boolean := true;
  s,s1:string;
  
procedure glav();
begin
  if winlog = true then
  begin
    Window.Title :=bym + '\' + lis + '\' + list + '.jpg';
    SetPenColor(clBlue);
    list := 0;
    Window.Init(0, 0, 1900, 900, clWhite);
    Window.Clear();
    Window.CenterOnScreen();
    SetFontSize(24);
    textout(Trunc(WindowWidth / 2) - Trunc(TextWidth('Тетради в линейку') / 2), 10, 'Тетради в линейку');
    textout(trunc(WindowWidth / 2) - Trunc(TextWidth('Тетради в клетку') / 2), 140, 'Тетради в кледку');
    for var i := 1 to 27 do
    begin
      if not FileExists('tetrad v lineyky\' + i + '\0.jpg') then 
        plusl[i] := new PictureABC(70 * i - 65, 0 + 50, 'dop\plus.jpg')
      else 
        begin
        plusl[i] := new PictureABC(70 * i - 65, 0 + 50, 'tetrad v lineyky\' + i + '\0.jpg');
        plusl[i].Width := 60;
        plusl[i].Height := 80;
      end;
      if not FileExists('tetrad v kledky\' + i + '\0.jpg') then 
        plusk[i] := new PictureABC(70 * i - 65, 90 + 100, 'dop\plus.jpg')
      else 
        begin
        plusk[i] := new PictureABC(70 * i - 65, 90 + 100, 'tetrad v kledky\' + i + '\0.jpg');
        plusk[i].Width := 60;
        plusk[i].Height := 80;
      end;
    end;
    rama := new PictureABC(xr, yr, 'dop\rama.png');
    rama.ToFront;
  end;
end;

procedure deldir(bym: string; lis: integer);
begin
  var f := System.IO.Directory.GetFiles(bym + '\' + lis + '\', '*.jpg');
  for var i := Low(f) to High(f) do System.IO.File.Delete(f[i]);
  System.IO.Directory.Delete(bym + '\' + lis);
end;

procedure copydir(fl1, fl2: string);
begin
  if not System.IO.Directory.Exists(fl2) then
  begin
    CreateDir(fl2);
    var f := System.IO.Directory.GetFiles(fl1, '*.jpg');
    for var i := Low(f) to High(f) do
    begin
      var sd: string := f[i];
      if i = 2 then
        for var n := 2 to 46 do
        begin
          var str: string := fl2 + n.tostring() + RightStr(sd, 4);
          System.IO.File.Copy(sd, str);
        end
      else
      begin
        var k: integer;
        if i > 2 then  k := i + 44 else k := i;
        var str: string := fl2 + k.tostring() + RightStr(sd, 4);
        System.IO.File.Copy(sd, str);
      end;
    end;
  end;
end;

procedure keydown(key: integer);
begin
  if winlog = true then 
  begin
    if key = VK_Up then 
      if yr < 100 then yr := yr 
      else
         begin
        yr := yr - 140;
        rama.MoveTo(xr, yr);
        bym := 'tetrad v lineyky';
        end;
    if key = VK_Down then
      if yr < 150 then
      begin
        yr := yr + 140;
        rama.MoveTo(xr, yr);
        bym := 'tetrad v kledky'
      end;
    if key = VK_Left then 
      if xr < 50 then 
      begin
        xr := xr;
        lis := lis;
      end
      else
           begin
        lis := lis - 1;
        xr := xr - 70;
        rama.MoveTo(xr, yr);
      end;
    if key = VK_Right then 
      if xr > 1760 then 
      begin
        xr := xr;
        lis := lis;
      end
      else begin
        xr := xr + 70;
        rama.MoveTo(xr, yr);
        lis := lis + 1;
      end;
    if key = VK_Enter then 
    begin
      winlog := false;
      if FileExists(bym + '\' + lis + '\0.jpg') then 
        Window.Load(bym + '\' + lis + '\0.jpg')
      else
        begin
  s := bym+'\0\';
  s1 :=bym+'\'+lis+'\';
  copydir(s, s1);
   Window.Load(bym + '\' + lis + '\0.jpg')
   end;
  end;
  end;
  
  if winlog = false then
  begin
    rama.Destroy;
    for var k1 := 1 to 27 do
    begin
      plusk[k1].Destroy;
      plusl[k1].Destroy;
    end;
    if key = VK_End then begin
      Window.Save(bym + '\' + lis + '\' + list + '.jpg');
      winlog := true;
      glav();
    end;
    
    if key = VK_Delete then 
      if FileExists(bym + '\' + lis + '\0.jpg') then 
      begin
        deldir(bym, lis);
        winlog := true;
        glav();
      end;
    if key = vk_x then SetPenColor(clBlack);
    if key = vk_z then SetPenColor(clWhite);
    if key = vk_c then SetPenColor(clBlue);
    if key = vk_v then SetPenColor(clred);      
    
    case key of
      VK_Right:
        begin
          Window.Save(bym + '\' + lis + '\' + list + '.jpg');
          if FileExists(bym + '\' + lis + '\' + (list+1) + '.jpg') then
            list := list + 1;
          Window.Load(bym + '\' + lis + '\' + list + '.jpg');    
        end;
      VK_Left:
        begin
          Window.Save(bym + '\' + lis + '\' + list + '.jpg');
          if list > 0 then
            list := list - 1
          else
            list := 0;
          if FileExists(bym + '\' + lis + '\' + list + '.jpg') then
            Window.Load(bym + '\' + lis + '\' + list + '.jpg');    
        end;
      VK_Up:
      if (FileExists(bym + '\' + lis + '\' + list + '.jpg') and (list=0) or (list=48)) then
        begin
          Window.Save(bym + '\' + lis + '\' + list + '.jpg');
          lis := lis + 1;
          while not FileExists(bym + '\' + lis + '\' + list + '.jpg') do
            lis := lis - 1;
          Window.Load(bym + '\' + lis + '\' + list + '.jpg');    
        end;
      VK_Down:
      if (FileExists(bym + '\' + lis + '\' + list + '.jpg') and (list=0) or (list=48)) then
        begin
          Window.Save(bym + '\' + lis + '\' + list + '.jpg');
          lis := lis - 1;
          if lis = 0 then 
            begin
            lis := lis + 1;
          if FileExists(bym + '\' + lis + '\' + list + '.jpg') then
            Window.Load(bym + '\' + lis + '\' + list + '.jpg');    
        end;
        end;
    end;
  end;
  Window.Title :=bym + '\' + lis + '\' + list + '.jpg';
end;

procedure closewin();
begin
  if winlog = false then Window.Save(bym + '\' + lis + '\' + list + '.jpg');
end;

procedure MouseDown(x, y, mb: integer);
begin
  MoveTo(x, y);
end;

procedure MouseMove(x, y, mb: integer);
begin
  if mb = 1 then LineTo(x, y);
end;

begin
MainForm.Icon := new System.Drawing.Icon(System.Reflection.Assembly.GetExecutingAssembly().GetManifestResourceStream('notebook.ico'));
   glav();
  OnKeyDown := keydown; 
  OnMouseDown := MouseDown;
  OnMouseMove := MouseMove;
  OnClose := closewin;
end.
