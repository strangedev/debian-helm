# debian-helm

Debian package for [helm.sh](https://helm.sh)

## License

The license for helm can be found at `helm.LICENSE`.
The license for this repository, excluding the `helm` binary,
can be found at `deb.LICENSE`.

## Releases

You can find the built `.deb` files on the [releases page](https://github.com/strangedev/debian-helm/releases).

## How to build a release

Docker is required.

```bash
./build.sh
```

The `.deb` files will be written to `./out`.
