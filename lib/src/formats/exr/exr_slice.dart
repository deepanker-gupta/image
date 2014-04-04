part of image;

class ExrSlice {
  final ExrChannel channel;
  final Uint8List bytes;
  int width;
  int height;
  var data;

  ExrSlice(ExrChannel ch, int width, int height) :
    channel = ch,
    this.width = width,
    this.height = height,
    bytes = new Uint8List(width * height * ch.size) {
    data = (ch.type == ExrChannel.TYPE_FLOAT) ?
           new Float32List.view(bytes.buffer) :
           (ch.type == ExrChannel.TYPE_HALF) ?
           new Uint16List.view(bytes.buffer) :
           new Uint32List.view(bytes.buffer);
  }

  getPixel(int x, int y) {
    int pi = y * width + x;
    return (channel.type == ExrChannel.TYPE_HALF) ?
           new Half.fromBits(data[pi]) :
           data[pi];
  }
}