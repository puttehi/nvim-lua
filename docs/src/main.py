import sys
import keymaps


def main():
    """Entrypoint"""

    print(keymaps.generate_dict())
    return 0


if __name__ == "__main__":
    sys.exit(main())
