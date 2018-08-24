# brew

  The Homebrew/Linuxbrew package manager for Linux.

- See all homebrew-installed formula

    brew list


- Search for available formulas

    brew search text


- Install the latest stable version of a formula (use `--devel` for development versions)

    brew install formula


- Upgrade an installed formula (with no formula name all installed formula will be updated)

    brew upgrade formula


- See all installed versions of formula

    brew info formula


- Use the version 10.20 of formula instead of the current version

    brew switch formula 10.20


- Update Linuxbrew/Homebrew

    brew update


- Check your Linuxbrew installation for potential problems

    brew doctor


- See your active taps: Taps are additional source of formulas

    brew tap


- Activate the `homebrew/versions` tap

    brew tap homebrew/versions


- Deactivate the `homebrew/versions` tap

    brew untap homebrew/versions


- Switch to a different installed version of a formula

    brew switch node 0.12.20

