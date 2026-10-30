# Mod Manager / Gerenciador de Mods - Little Big Adventure 2 (Twinsen)
# Open it with "LBA2 Mod Manager.bat" (or "Gerenciador de Mods.bat"). Nothing to install.

param([string]$Acao = "", [string]$PastaJogo = "")

$ErrorActionPreference = "Stop"
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}

$PastaFerramentas = Split-Path -Parent $PSCommandPath
$PastaMods = Split-Path -Parent $PastaFerramentas
if (-not $PastaJogo) { $PastaJogo = Split-Path -Parent $PastaMods }
$PastaBackup = Join-Path $PastaMods "_backup_originais"
$ArqEstado = Join-Path $PastaMods "_mods_ativos.txt"
$ArqNovos = Join-Path $PastaBackup "_arquivos_novos.txt"
$ArqIdioma = Join-Path $PastaMods "_idioma.txt"

# ------------------------------------------------------------------ idioma / language
# PT ou EN: textos do gerenciador e dos mods (descricoes e o que os mods
# escrevem na tela do jogo). Guardado em _idioma.txt; tecla L troca.
$Idioma = ""
if (Test-Path -LiteralPath $ArqIdioma) { $Idioma = ([IO.File]::ReadAllText($ArqIdioma)).Trim().ToUpper() }
if ($Idioma -ne "PT" -and $Idioma -ne "EN") {
    $Idioma = if ((Get-Culture).TwoLetterISOLanguageName -eq "pt") { "PT" } else { "EN" }
}

$Txt = @{
  EN = @{
    NaoAchado = "Game not found in: {0}"
    PastaMods = "The 'Mods' folder must be inside the LBA2 folder (next to the 'Common' folder)."
    EnterSair = "Press Enter to exit"
    SemPermissao = "No permission to write to the game folder, even as administrator."
    PedindoAdmin = "The game folder is protected by Windows. Asking for administrator permission..."
    Restaurado = "Game restored to the original."
    Titulo = "   MOD MANAGER - Little Big Adventure 2"
    SemMods = "  No mods found in the Mods folder."
    SecTexto = "TEXT AND VISUAL MODS (work in both versions of the game)"
    SecMotor = "MODS (community version - key P)"
    Ligado = "[  ON  ]"
    OpNumero = "  Type a mod NUMBER and press Enter to turn it on/off"
    OpP = "  P = PLAY with the chosen mods"
    OpO = "  O = play the ORIGINAL GOG version (no mods)"
    OpR = "  R = revert everything (original game)   Q = quit"
    OpL = "  L = language: ENGLISH (change to Portuguese)"
    Opcao = "  Option"
    Revertido = "  Done! The game is back to the original."
    SemMotor = "  Community version not found in ferramentas\motor."
    SAC1 = "  Windows Smart App Control blocked the community version (lba2cc.exe)."
    SAC2 = "  It blocks programs that are not digitally signed by a company."
    SAC3 = "  To play with the gameplay mods: Windows Security > App & browser control >"
    SAC4 = "  Smart App Control settings > Off. Then press P again."
    SAC5 = "  (Key O still opens the original game.)"
    EnterContinuar = "  Press Enter to continue"
    Iniciando = "  Starting the game..."
    IniciandoOrig = "  Starting the original game..."
    SemOrig = "  TLBA2C.exe not found."
    Desligado = "turned off"
    LigadoMsg = "turned on"
    Pronto = "  Done! '{0}' {1}."
    Erro = "  ERROR: {0}"
    Mantidos = "  Kept the mods that were already on."
    Seguro = "  Restored the original game to be safe."
    Aplicando = "  Applying: {0}"
    NaoEncontrado = "  Warning: mod '{0}' not found, skipped."
    Conflito = "  Warning: '{0}' replaces {1}, also changed by '{2}' (the last one wins)."
    NaoExiste = "The mod uses {0}, which does not exist in the game."
    Idioma = "  Language: English."
  }
  PT = @{
    NaoAchado = "Jogo não encontrado em: {0}"
    PastaMods = "A pasta 'Mods' precisa ficar dentro da pasta do LBA2 (ao lado da pasta 'Common')."
    EnterSair = "Aperte Enter para sair"
    SemPermissao = "Sem permissão para gravar na pasta do jogo, mesmo como administrador."
    PedindoAdmin = "A pasta do jogo é protegida pelo Windows. Pedindo permissão de administrador..."
    Restaurado = "Jogo restaurado ao original."
    Titulo = "   GERENCIADOR DE MODS - Little Big Adventure 2"
    SemMods = "  Nenhum mod encontrado na pasta Mods."
    SecTexto = "MODS DE TEXTO E VISUAIS (valem nas duas versões do jogo)"
    SecMotor = "MODS (versão da comunidade - tecla P)"
    Ligado = "[LIGADO]"
    OpNumero = "  Digite o NÚMERO de um mod e aperte Enter para ligar/desligar"
    OpP = "  P = JOGAR com os mods escolhidos"
    OpO = "  O = jogar a versão ORIGINAL da GOG (sem os mods)"
    OpR = "  R = reverter tudo (jogo original)   Q = sair"
    OpL = "  L = idioma: PORTUGUÊS (mudar para inglês)"
    Opcao = "  Opção"
    Revertido = "  Pronto! O jogo voltou ao original."
    SemMotor = "  Versão da comunidade não encontrada em ferramentas\motor."
    SAC1 = "  O Controle Inteligente de Aplicativos do Windows bloqueou a versão da comunidade (lba2cc.exe)."
    SAC2 = "  Ele bloqueia programas que não têm assinatura digital de uma empresa."
    SAC3 = "  Para jogar com os mods de jogabilidade: Segurança do Windows > Controle de aplicativos e do navegador >"
    SAC4 = "  Configurações do Controle Inteligente de Aplicativos > Desativado. Depois aperte P de novo."
    SAC5 = "  (A tecla O continua abrindo o jogo original.)"
    EnterContinuar = "  Aperte Enter para continuar"
    Iniciando = "  Abrindo o jogo..."
    IniciandoOrig = "  Abrindo o jogo original..."
    SemOrig = "  TLBA2C.exe não encontrado."
    Desligado = "desligado"
    LigadoMsg = "ligado"
    Pronto = "  Pronto! '{0}' {1}."
    Erro = "  ERRO: {0}"
    Mantidos = "  Mantidos os mods que já estavam ligados."
    Seguro = "  Jogo original restaurado por segurança."
    Aplicando = "  Aplicando: {0}"
    NaoEncontrado = "  Aviso: mod '{0}' não encontrado, ignorado."
    Conflito = "  Aviso: '{0}' troca {1}, que também é mudado por '{2}' (vale o último)."
    NaoExiste = "O mod usa {0}, que não existe no jogo."
    Idioma = "  Idioma: português."
  }
}
function T($k) { return $Txt[$Idioma][$k] }

# ------------------------------------------------------------------ nucleo (C#)
if (-not ("Lba2Mod.Core" -as [type])) {
Add-Type -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace Lba2Mod {
public static class Core {
    static readonly string[] Langs = { "EN", "FR", "DE", "ES", "IT", "PT" };
    static readonly string[] Banks = { "sys", "cre", "gam", "000", "001", "002", "003", "004", "005", "006", "007", "008", "009", "010", "011" };
    const string Cp850 = "ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜø£Ø×ƒáíóúñÑªº¿®¬½¼¡«»░▒▓│┤ÁÂÀ©╣║╗╝¢¥┐└┴┬├─┼ãÃ╚╔╩╦╠═╬¤ðÐÊËÈıÍÎÏ┘┌█▄¦Ì▀ÓßÔÒõÕµþÞÚÛÙýÝ¯´­±‗¾¶§÷¸°¨·¹³²■ ";

    static uint U32(byte[] d, int o) { return BitConverter.ToUInt32(d, o); }
    static ushort U16(byte[] d, int o) { return BitConverter.ToUInt16(d, o); }

    public static int Count(byte[] d) { return (int)(U32(d, 0) / 4); }

    // Le uma entrada do HQR (descomprimida). null = vazia.
    public static byte[] Entry(byte[] d, int idx) {
        if (idx >= Count(d)) return null;
        int o = (int)U32(d, idx * 4);
        if (o == 0) return null;
        int size = (int)U32(d, o), csize = (int)U32(d, o + 4);
        short method = BitConverter.ToInt16(d, o + 8);
        int p = o + 10;
        byte[] outb = new byte[size];
        if (method == 0) { Array.Copy(d, p, outb, 0, size); return outb; }
        int n = 0, minb = method + 1;
        while (n < size) {
            byte flag = d[p++];
            for (int b = 0; b < 8 && n < size; b++) {
                if ((flag & (1 << b)) != 0) { outb[n++] = d[p++]; }
                else {
                    int lo = d[p], hi = d[p + 1]; p += 2;
                    int len = (lo & 0x0F) + minb;
                    int src = n - (((hi << 4) | (lo >> 4)) + 1);
                    for (int k = 0; k < len && n < size; k++) outb[n++] = outb[src + k];
                }
            }
        }
        return outb;
    }

    // Novo HQR = original intacto + entradas novas no fim (sem compressao).
    // A entrada 0 e especial: a posicao dela tambem diz o tamanho da tabela,
    // entao ela e inserida logo apos a tabela e o resto e deslocado.
    static byte[] Header(byte[] p) {
        byte[] h = new byte[10 + p.Length];
        Array.Copy(BitConverter.GetBytes((uint)p.Length), 0, h, 0, 4);
        Array.Copy(BitConverter.GetBytes((uint)p.Length), 0, h, 4, 4);
        Array.Copy(p, 0, h, 10, p.Length);
        return h;
    }

    public static byte[] Patch(byte[] d, Dictionary<int, byte[]> repl) {
        int count = Count(d), table = count * 4;
        List<int> keys = new List<int>(repl.Keys); keys.Sort();
        foreach (int k in keys)
            if (k < 0 || k >= count || U32(d, k * 4) == 0 || U32(d, k * 4) >= (uint)d.Length)
                throw new Exception("Entry " + k + " does not exist in this file.");
        byte[] ins = repl.ContainsKey(0) ? Header(repl[0]) : new byte[0];
        int delta = ins.Length;
        MemoryStream ms = new MemoryStream();
        ms.Write(d, 0, table);
        ms.Write(ins, 0, ins.Length);
        ms.Write(d, table, d.Length - table);
        Dictionary<int, int> pos = new Dictionary<int, int>();
        foreach (int k in keys) {
            if (k == 0) { pos[0] = table; continue; }
            pos[k] = (int)ms.Length;
            byte[] h = Header(repl[k]);
            ms.Write(h, 0, h.Length);
        }
        byte[] outb = ms.ToArray();
        for (int i = 0; i < count; i++) {
            uint o = U32(d, i * 4);
            uint n;
            if (pos.ContainsKey(i)) n = (uint)pos[i];
            else if (o == 0) n = 0;
            else if (o >= (uint)d.Length) n = (uint)outb.Length;   // marca de fim de arquivo
            else n = o + (uint)delta;
            Array.Copy(BitConverter.GetBytes(n), 0, outb, i * 4, 4);
        }
        return outb;
    }

    public static byte[] Enc(string s) {
        byte[] r = new byte[s.Length];
        for (int i = 0; i < s.Length; i++) {
            char c = s[i];
            if (c < 128) r[i] = (byte)c;
            else { int j = Cp850.IndexOf(c); r[i] = (byte)(j >= 0 ? 128 + j : '?'); }
        }
        return r;
    }

    class Row { public ushort Id; public byte Attr; public byte[] Text; }

    static List<Row> ReadBank(byte[] d, int lang, int bank) {
        List<Row> rows = new List<Row>();
        int b = lang * 30 + bank * 2;
        byte[] order = Entry(d, b), text = Entry(d, b + 1);
        if (order == null || text == null || order.Length < 2) return rows;
        int cnt = order.Length / 2;
        for (int s = 0; s < cnt; s++) {
            int a = U16(text, s * 2), e = U16(text, s * 2 + 2);
            Row r = new Row(); r.Id = U16(order, s * 2);
            r.Attr = e > a ? text[a] : (byte)1;
            int end = a + 1; while (end < e && text[end] != 0) end++;
            r.Text = new byte[Math.Max(0, end - a - 1)];
            if (r.Text.Length > 0) Array.Copy(text, a + 1, r.Text, 0, r.Text.Length);
            rows.Add(r);
        }
        return rows;
    }

    static void BuildBank(List<Row> rows, out byte[] order, out byte[] text) {
        order = new byte[rows.Count * 2];
        MemoryStream body = new MemoryStream();
        int head = 2 * (rows.Count + 1);
        byte[] offs = new byte[head];
        for (int i = 0; i < rows.Count; i++) {
            Array.Copy(BitConverter.GetBytes(rows[i].Id), 0, order, i * 2, 2);
            Array.Copy(BitConverter.GetBytes((ushort)(head + body.Length)), 0, offs, i * 2, 2);
            body.WriteByte(rows[i].Attr); body.Write(rows[i].Text, 0, rows[i].Text.Length); body.WriteByte(0);
        }
        if (head + body.Length > 0xFFFF) throw new Exception("Text bank is too big (64 KB limit).");
        Array.Copy(BitConverter.GetBytes((ushort)(head + body.Length)), 0, offs, rows.Count * 2, 2);
        text = new byte[head + body.Length];
        Array.Copy(offs, text, head);
        Array.Copy(body.ToArray(), 0, text, head, (int)body.Length);
    }

    // Aplica um textos.txt sobre o TEXT.HQR atual e devolve o novo TEXT.HQR.
    public static byte[] ApplyTextos(byte[] d, string path) {
        string[] lines = File.ReadAllLines(path, Encoding.UTF8);
        List<int> langs = null; int bank = -1;
        // (lang,bank) -> lista de (id, texto) em ordem
        Dictionary<int, List<KeyValuePair<int, string>>> groups = new Dictionary<int, List<KeyValuePair<int, string>>>();
        List<int> orderKeys = new List<int>();
        for (int ln = 0; ln < lines.Length; ln++) {
            string line = lines[ln].TrimEnd('\r', '\n');
            string st = line.Trim();
            if (st.Length == 0 || st.StartsWith("#")) continue;
            if (st.StartsWith("[") && st.EndsWith("]")) {
                string[] p = st.Substring(1, st.Length - 2).Split(new char[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries);
                if (p.Length != 2) throw new Exception(Path.GetFileName(path) + " line " + (ln + 1) + ": use [LANGUAGE bank], e.g. [EN sys]");
                langs = new List<int>();
                if (p[0] == "*") { for (int i = 0; i < 6; i++) langs.Add(i); }
                else { int li = Array.IndexOf(Langs, p[0].ToUpper()); if (li < 0) throw new Exception(Path.GetFileName(path) + " line " + (ln + 1) + ": unknown language '" + p[0] + "' (use EN FR DE ES IT PT or *)"); langs.Add(li); }
                bank = Array.IndexOf(Banks, p[1].ToLower());
                if (bank < 0) throw new Exception(Path.GetFileName(path) + " line " + (ln + 1) + ": unknown bank '" + p[1] + "' (use sys gam 000..011)");
                continue;
            }
            int eq = line.IndexOf('=');
            int id;
            if (eq < 0 || langs == null || !int.TryParse(line.Substring(0, eq).Trim(), out id))
                throw new Exception(Path.GetFileName(path) + " line " + (ln + 1) + ": expected 'number = text'");
            string v = line.Substring(eq + 1); if (v.StartsWith(" ")) v = v.Substring(1);
            foreach (int lg in langs) {
                int key = lg * 100 + bank;
                if (!groups.ContainsKey(key)) { groups[key] = new List<KeyValuePair<int, string>>(); orderKeys.Add(key); }
                groups[key].Add(new KeyValuePair<int, string>(id, v));
            }
        }
        Dictionary<int, byte[]> repl = new Dictionary<int, byte[]>();
        foreach (int key in orderKeys) {
            int lg = key / 100, bk = key % 100;
            List<Row> rows = ReadBank(d, lg, bk);
            foreach (KeyValuePair<int, string> kv in groups[key]) {
                Row found = null;
                foreach (Row r in rows) if (r.Id == kv.Key) { found = r; break; }
                if (found == null) { found = new Row(); found.Id = (ushort)kv.Key; found.Attr = 1; rows.Add(found); }
                found.Text = Enc(kv.Value);
            }
            byte[] o, t; BuildBank(rows, out o, out t);
            int b = lg * 30 + bk * 2;
            repl[b] = o; repl[b + 1] = t;
        }
        return Patch(d, repl);
    }
}
}
'@
}

# ------------------------------------------------------------------ funcoes
function Escrever($texto, $cor = "Gray") { Write-Host $texto -ForegroundColor $cor }

function Ler-Ini($arq) {
    $r = @{ nome = ""; descricao = ""; autor = ""; versao = ""; motor = "" }
    foreach ($l in [IO.File]::ReadAllLines($arq, [Text.Encoding]::UTF8)) {
        if ($l -match '^\s*([A-Za-z_]+)\s*=\s*(.*)$') { $r[$matches[1].ToLower()] = $matches[2].Trim() }
    }
    # nome_pt / descricao_pt / nome_en / descricao_en: no idioma escolhido
    $suf = "_" + $Idioma.ToLower()
    if ($r.ContainsKey("nome" + $suf) -and $r["nome" + $suf]) { $r.nome = $r["nome" + $suf] }
    if ($r.ContainsKey("descricao" + $suf) -and $r["descricao" + $suf]) { $r.descricao = $r["descricao" + $suf] }
    return $r
}

function Listar-Mods {
    $lista = @()
    foreach ($d in Get-ChildItem -LiteralPath $PastaMods -Directory | Sort-Object Name) {
        $ini = Join-Path $d.FullName "mod.ini"
        if (Test-Path -LiteralPath $ini) {
            $info = Ler-Ini $ini
            if (-not $info.nome) { $info.nome = $d.Name }
            $lista += [pscustomobject]@{ Pasta = $d.Name; Caminho = $d.FullName; Nome = $info.nome; Descricao = $info.descricao; Autor = $info.autor; Versao = $info.versao; Motor = $info.motor }
        }
    }
    return $lista
}

function Ler-Ativos {
    if (Test-Path -LiteralPath $ArqEstado) { return @([IO.File]::ReadAllLines($ArqEstado, [Text.Encoding]::UTF8) | Where-Object { $_.Trim() }) }
    return @()
}

function Liberar($p) {
    if (Test-Path -LiteralPath $p) { $i = Get-Item -LiteralPath $p -Force; if ($i.IsReadOnly) { $i.IsReadOnly = $false } }
}

function Fazer-Backup($rel) {
    $orig = Join-Path $PastaJogo $rel
    $bak = Join-Path $PastaBackup $rel
    if (Test-Path -LiteralPath $bak) { return }
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $bak) | Out-Null
    if (Test-Path -LiteralPath $orig) { Copy-Item -LiteralPath $orig -Destination $bak -Force }
    else {
        New-Item -ItemType Directory -Force -Path $PastaBackup | Out-Null
        Add-Content -LiteralPath $ArqNovos -Value $rel -Encoding UTF8
    }
}

function Restaurar-Originais {
    if (-not (Test-Path -LiteralPath $PastaBackup)) { return }
    foreach ($f in Get-ChildItem -LiteralPath $PastaBackup -Recurse -File) {
        if ($f.FullName -eq $ArqNovos) { continue }
        $rel = $f.FullName.Substring($PastaBackup.Length).TrimStart('\', '/')
        $dest = Join-Path $PastaJogo $rel
        Liberar $dest
        Copy-Item -LiteralPath $f.FullName -Destination $dest -Force
    }
    if (Test-Path -LiteralPath $ArqNovos) {
        foreach ($rel in [IO.File]::ReadAllLines($ArqNovos)) {
            $p = Join-Path $PastaJogo $rel.Trim()
            if ($rel.Trim() -and (Test-Path -LiteralPath $p)) { Liberar $p; Remove-Item -LiteralPath $p -Force }
        }
        Remove-Item -LiteralPath $ArqNovos -Force
    }
}

# Volta tudo ao original e aplica, em ordem, os mods da lista.
function Aplicar($ativos) {
    Restaurar-Originais
    $todos = Listar-Mods
    $dados = @{}   # caminho relativo -> byte[]
    $quem = @{}    # "arquivo:indice" -> mod (para avisar conflitos)
    foreach ($pasta in $ativos) {
        $mod = $todos | Where-Object { $_.Pasta -eq $pasta }
        if (-not $mod) { Escrever ((T "NaoEncontrado") -f $pasta) Yellow; continue }
        if ($mod.Motor) { continue } # mod do motor: so vale ao jogar com J
        Escrever ((T "Aplicando") -f $mod.Nome) Cyan

        $tx = Join-Path $mod.Caminho "textos.txt"
        if (Test-Path -LiteralPath $tx) {
            $rel = "Common\TEXT.HQR"
            if (-not $dados.ContainsKey($rel)) { $dados[$rel] = [IO.File]::ReadAllBytes((Join-Path $PastaJogo $rel)) }
            $dados[$rel] = [Lba2Mod.Core]::ApplyTextos($dados[$rel], $tx)
        }

        $hq = Join-Path $mod.Caminho "hqr"
        if (Test-Path -LiteralPath $hq) {
            foreach ($dir in Get-ChildItem -LiteralPath $hq -Directory) {
                $rel = "Common\" + $dir.Name
                if (-not (Test-Path -LiteralPath (Join-Path $PastaJogo $rel))) { throw ((T "NaoExiste") -f $rel) }
                if (-not $dados.ContainsKey($rel)) { $dados[$rel] = [IO.File]::ReadAllBytes((Join-Path $PastaJogo $rel)) }
                $repl = New-Object 'System.Collections.Generic.Dictionary[int,byte[]]'
                foreach ($f in Get-ChildItem -LiteralPath $dir.FullName -File) {
                    $idx = 0
                    if (-not [int]::TryParse($f.BaseName, [ref]$idx)) { continue }
                    $chave = "$($dir.Name):$idx"
                    if ($quem.ContainsKey($chave)) { Escrever ((T "Conflito") -f $mod.Nome, $chave, $quem[$chave]) Yellow }
                    $quem[$chave] = $mod.Nome
                    $repl[$idx] = [IO.File]::ReadAllBytes($f.FullName)
                }
                $dados[$rel] = [Lba2Mod.Core]::Patch($dados[$rel], $repl)
            }
        }

        $arqs = Join-Path $mod.Caminho "arquivos"
        if (Test-Path -LiteralPath $arqs) {
            foreach ($f in Get-ChildItem -LiteralPath $arqs -Recurse -File) {
                $rel = $f.FullName.Substring($arqs.Length).TrimStart('\', '/')
                Fazer-Backup $rel
                $dest = Join-Path $PastaJogo $rel
                New-Item -ItemType Directory -Force -Path (Split-Path -Parent $dest) | Out-Null
                Liberar $dest
                Copy-Item -LiteralPath $f.FullName -Destination $dest -Force
                $dados.Remove($rel)
            }
        }
    }
    foreach ($rel in $dados.Keys) {
        Fazer-Backup $rel
        Liberar (Join-Path $PastaJogo $rel)
        [IO.File]::WriteAllBytes((Join-Path $PastaJogo $rel), $dados[$rel])
    }
    [IO.File]::WriteAllLines($ArqEstado, [string[]]$ativos, (New-Object Text.UTF8Encoding($false)))
}

function Testar-Escrita {
    try {
        $t = Join-Path $PastaJogo "Common\_teste_mods.tmp"
        [IO.File]::WriteAllText($t, "ok"); Remove-Item -LiteralPath $t -Force
        return $true
    } catch { return $false }
}

# ------------------------------------------------------------------ inicio
if (-not (Test-Path -LiteralPath (Join-Path $PastaJogo "Common\TEXT.HQR"))) {
    Escrever ((T "NaoAchado") -f $PastaJogo) Red
    Escrever (T "PastaMods") Yellow
    if (-not $Acao) { Read-Host (T "EnterSair") }
    exit 1
}

if (-not (Testar-Escrita)) {
    if ($Acao -eq "elevado") { Escrever (T "SemPermissao") Red; Read-Host (T "EnterSair"); exit 1 }
    Escrever (T "PedindoAdmin") Yellow
    Start-Process powershell.exe -Verb RunAs -ArgumentList @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSCommandPath`"", "elevado")
    exit 0
}

# ------------------------------------------------------------------ versoes anteriores
# Pastas de mods renomeadas ou retiradas do pacote: arruma sozinho ao abrir.
$Renomeados = @{ "Camera estilo GTA" = "Camera Orbital" }
$Retirados = @("Alien Blaster", "Pedras e grama mais limpas")
function Arrumar-Versoes {
    $ativos = @(Ler-Ativos)
    $novo = @()
    $refazer = $false
    foreach ($a in $ativos) {
        if ($Retirados -contains $a) {
            $ini = Join-Path (Join-Path $PastaMods $a) "mod.ini"
            if ((Test-Path -LiteralPath $ini) -and -not (Ler-Ini $ini).motor) { $refazer = $true } # mudava arquivos do jogo
            continue
        }
        if ($Renomeados.ContainsKey($a)) { $a = $Renomeados[$a] }
        if ($novo -notcontains $a) { $novo += $a }
    }
    foreach ($velho in $Renomeados.Keys) {
        $pv = Join-Path $PastaMods $velho
        $pn = Join-Path $PastaMods $Renomeados[$velho]
        if (Test-Path -LiteralPath $pv) {
            if (Test-Path -LiteralPath $pn) { Remove-Item -LiteralPath $pv -Recurse -Force }
            else { Rename-Item -LiteralPath $pv -NewName $Renomeados[$velho] }
        }
    }
    if ($refazer) { Aplicar $novo } # devolve os arquivos originais do jogo
    foreach ($r in $Retirados) {
        $p = Join-Path $PastaMods $r
        if (Test-Path -LiteralPath $p) { Remove-Item -LiteralPath $p -Recurse -Force }
    }
    if (($novo -join "|") -ne ($ativos -join "|")) {
        [IO.File]::WriteAllLines($ArqEstado, [string[]]$novo, (New-Object Text.UTF8Encoding($false)))
    }
}
Arrumar-Versoes

# modo sem menu (usado em testes): -Acao aplicar|reverter
if ($Acao -eq "reverter") { Aplicar @(); Escrever (T "Restaurado") Green; exit 0 }
if ($Acao -eq "aplicar") { Aplicar (Ler-Ativos); exit 0 }

while ($true) {
    Clear-Host
    $mods = @(Listar-Mods | Sort-Object @{ Expression = { [bool]$_.Motor } }, Pasta)
    $ativos = @(Ler-Ativos)
    Escrever "==================================================" DarkCyan
    Escrever (T "Titulo") White
    Escrever "==================================================" DarkCyan
    Escrever ""
    if ($mods.Count -eq 0) { Escrever (T "SemMods") Yellow }
    $secoes = @(
        @{ Titulo = (T "SecTexto"); Motor = $false },
        @{ Titulo = (T "SecMotor"); Motor = $true })
    foreach ($sec in $secoes) {
        $tem = $false
        for ($i = 0; $i -lt $mods.Count; $i++) {
            $m = $mods[$i]
            if ([bool]$m.Motor -ne $sec.Motor) { continue }
            if (-not $tem) { Escrever ""; Escrever ("  " + $sec.Titulo) DarkCyan; $tem = $true }
            $on = $ativos -contains $m.Pasta
            $marca = if ($on) { (T "Ligado") } else { "[      ]" }
            $cor = if ($on) { "Green" } else { "Gray" }
            Escrever ("  {0,2}. {1} {2}" -f ($i + 1), $marca, $m.Nome) $cor
            if ($m.Descricao) { Escrever ("             " + $m.Descricao) DarkGray }
        }
    }
    Escrever ""
    Escrever (T "OpNumero") White
    Escrever (T "OpP") White
    Escrever (T "OpO") White
    Escrever (T "OpR") White
    Escrever (T "OpL") White
    $op = (Read-Host (T "Opcao")).Trim().ToUpper()

    try {
        if ($op -eq "Q" -or $op -eq "S" -or $op -eq "") { break }
        elseif ($op -eq "L" -or $op -eq "I") {
            $Idioma = if ($Idioma -eq "PT") { "EN" } else { "PT" }
            [IO.File]::WriteAllText($ArqIdioma, $Idioma, (New-Object Text.UTF8Encoding($false)))
            Escrever (T "Idioma") Green; Start-Sleep 1
        }
        elseif ($op -eq "R") {
            Aplicar @()
            Escrever (T "Revertido") Green; Start-Sleep 2
        }
        elseif ($op -eq "P" -or $op -eq "J") {
            $motor = Join-Path $PastaFerramentas "motor\lba2cc.exe"
            if (-not (Test-Path -LiteralPath $motor)) { Escrever (T "SemMotor") Yellow; Start-Sleep 3; continue }
            $chaves = @()
            foreach ($m in $mods) { if ($m.Motor -and ($ativos -contains $m.Pasta)) { $chaves += $m.Motor } }
            $env:LBA2_MODS_MOTOR = ($chaves -join ",")
            $env:LBA2_MODS_LANG = $Idioma   # textos que os mods mostram no jogo
            try {
                $lingua = if ($Idioma -eq "PT") { "PO" } else { "EN" }   # idioma do jogo = o do gerenciador
                Start-Process -FilePath $motor -ArgumentList @("--game-dir", "`"$PastaJogo`"", "--language", $lingua) -WorkingDirectory (Split-Path -Parent $motor) -ErrorAction Stop
            } catch {
                $msg = $_.Exception.Message
                if ($msg -match "Application Control|Controle de Aplicativo|Smart App") {
                    Escrever "" ; Escrever (T "SAC1") Yellow
                    Escrever (T "SAC2") Yellow
                    Escrever (T "SAC3") White
                    Escrever (T "SAC4") White
                    Escrever (T "SAC5") Gray
                    Read-Host (T "EnterContinuar")
                    continue
                }
                throw
            }
            Escrever (T "Iniciando") Green; Start-Sleep 2
        }
        elseif ($op -eq "O" -or $op -eq "G") {
            $exe = Join-Path $PastaJogo "TLBA2C.exe"
            if (Test-Path -LiteralPath $exe) { Start-Process -FilePath $exe -WorkingDirectory $PastaJogo; Escrever (T "IniciandoOrig") Green; Start-Sleep 2 }
            else { Escrever (T "SemOrig") Yellow; Start-Sleep 2 }
        }
        elseif ($op -match '^\d+$' -and [int]$op -ge 1 -and [int]$op -le $mods.Count) {
            $m = $mods[[int]$op - 1]
            if ($ativos -contains $m.Pasta) { $novo = @($ativos | Where-Object { $_ -ne $m.Pasta }); $msg = (T "Desligado") }
            else { $novo = @($ativos) + $m.Pasta; $msg = (T "LigadoMsg") }
            if ($m.Motor) { [IO.File]::WriteAllLines($ArqEstado, [string[]]$novo, (New-Object Text.UTF8Encoding($false))) }
            else { Aplicar $novo }
            Escrever ((T "Pronto") -f $m.Nome, $msg) Green; Start-Sleep 2
        }
    } catch {
        Escrever "" ; Escrever ((T "Erro") -f $_.Exception.Message) Red
        try { Aplicar $ativos; Escrever (T "Mantidos") Yellow }
        catch { Aplicar @(); Escrever (T "Seguro") Yellow }
        Read-Host (T "EnterContinuar")
    }
}
