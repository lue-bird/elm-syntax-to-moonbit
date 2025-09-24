Using https://mooncakes.io/docs/Yoorkin/rabbit-tea
```bash
npm install
```
Develop with
```bash
npx vite
```
Whenever you make changes to the elm file(s), call the elm to moonbit transpiler from `main/`.

## limitations
- events must be explicitly implemented in your moonbit code (and custom events etc don't seem to be supported by rabbit-tea at all)
- preventing default and stopping propagation on events does not seem to be supported by rabbit-tea
- keyed dom nodes do not seem to be explicitly supported
- while I think it's possible to run it as wasm, I couldn't find documentation on it
- the project setup seems like slop to me, so many config files and a required sub-directory

Overall, this doesn't seem to be production-grade but is probably enough for simple apps.
