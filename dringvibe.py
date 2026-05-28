import sys
import random
import time
from pathlib import Path
import os
os.environ["PYGAME_HIDE_SUPPORT_PROMPT"] = "1"
import pygame
from pynput import keyboard
from rich.console import Console
from rich.panel import Panel

console = Console()

theme = sys.argv[1] if len(sys.argv) > 1 else "1"

base_dir = Path(__file__).resolve().parent
sounds_dir = base_dir / "sounds" / theme

if not sounds_dir.exists():
    console.print(Panel(f"[red]Theme not found:[/red] {sounds_dir}"))
    raise SystemExit(1)

sound_files = [
    p for p in sounds_dir.iterdir()
    if p.is_file() and p.suffix.lower() in (".wav", ".ogg", ".mp3")
]

if not sound_files:
    console.print(Panel(f"[red]No audio files found in:[/red] {sounds_dir}"))
    raise SystemExit(1)

console.print(Panel(
    f"[bold cyan]DRINGVIBE[/bold cyan]\n"
    f"Theme: [bold]{theme}[/bold]\n"
    f"Sounds: {len(sound_files)}"
))


pygame.mixer.init(frequency=44100, size=-16, channels=2, buffer=256)

sounds = []
for p in sound_files:
    try:
        sounds.append(pygame.mixer.Sound(str(p)))
    except Exception as e:
        console.print(f"[yellow]Skip[/yellow] {p.name}: {e}")

if not sounds:
    console.print(Panel(f"[red]Could not load any sounds from:[/red] {sounds_dir}"))
    raise SystemExit(1)

_last_play = 0.0
_min_interval = 0.03 

def play_random():
    global _last_play
    now = time.time()
    if now - _last_play < _min_interval:
        return
    _last_play = now
    random.choice(sounds).play()

def on_press(key):
    play_random()

with keyboard.Listener(on_press=on_press) as listener:
    listener.join()
