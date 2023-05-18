# image base:aarch64:latest
FROM archlinux:latest

# Change user to duvan
# Install dependencies
RUN pacman -Syu zsh git zsh-syntax-highlighting zsh-autosuggestions lsd bat openssh sudo github-cli gcc neovim --noconfirm

# configure user
ARG USER=duvan
ARG PASS="duvan"
RUN useradd -m -s /bin/zsh $USER && echo "$USER:$PASS" | chpasswd

# Add user to sudoers
RUN echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# Add user to wheel group
RUN usermod -aG wheel $USER
RUN ln -s /home/duvan/.zshrc /root/.zshrc
#workdir to home
WORKDIR /home/duvan
#zsh root default
RUN chsh -s /bin/zsh root
COPY .p10k.zsh /root/.p10k.zsh

#copy zshrc file to home directory
COPY .zshrc /home/duvan/.zshrc
COPY .ssh/* /home/duvan/.ssh/
COPY .p10k.zsh /home/duvan/.p10k.zsh

# Copy .zshrc file to home directory
COPY zsh_plugins/zsh-autocomplete /home/duvan/.zsh/zsh-autocomplete
COPY zsh_plugins/powerlevel10k /home/duvan/.zsh/powerlevel10k
COPY zsh_plugins/sudo.plugin.zsh /home/duvan/.zsh/sudo.plugin.zsh

CMD ["sudo", "-u", "duvan", "zsh"]
