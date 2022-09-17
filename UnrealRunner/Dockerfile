FROM ghcr.io/epicgames/unreal-engine:dev-5.0.3

# Create a folder
RUN mkdir actions-runner && cd actions-runner
# Download the latest runner package
RUN curl -o actions-runner-linux-x64-2.296.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.296.2/actions-runner-linux-x64-2.296.2.tar.gz
# Optional: Validate the hash
RUN echo "34a8f34956cdacd2156d4c658cce8dd54c5aef316a16bbbc95eb3ca4fd76429a  actions-runner-linux-x64-2.296.2.tar.gz" | shasum -a 256 -c
# Extract the installer
RUN tar xzf ./actions-runner-linux-x64-2.296.2.tar.gz

# Create the runner and start the configuration experience
RUN ./config.sh --url https://github.com/outoftheboxplugins --token AFB46MOE57KKZ2BD7AEBTMTDEV24S
# Last step, run it!

ENTRYPOINT ["./run.sh"]
