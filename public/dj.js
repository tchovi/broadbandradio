const socket = io();
function startStreaming() {
  navigator.mediaDevices.getUserMedia({ audio: true }).then(stream => {
    const mediaRecorder = new MediaRecorder(stream);
    mediaRecorder.ondataavailable = event => {
      if (event.data.size > 0) {
        socket.emit('dj-stream', event.data);
      }
    };
    mediaRecorder.start(1000);
  });
}
