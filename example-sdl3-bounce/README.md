I'm very unsure this is set up correctly for all platform!
```bash
moon run --target=native .
```
If it doesn't show window decorations but "libdecor-gtk-WARNING: Failed to initialize GTK" is printed,
run from a non-integrated terminal or launch your IDE as described in e.g. https://stackoverflow.com/a/79504123

If no window opens at all, you likely still need to install SDL3.

If you still have issues with linking or whatever feel free to open an issue, though I'm not sure I'll know anything more than you do :)
