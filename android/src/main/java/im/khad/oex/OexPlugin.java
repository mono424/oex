package im.khad.oex;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** OexPlugin */
public class OexPlugin implements FlutterPlugin, MethodCallHandler {
  private static final String CHANNEL = "khad.im.oex";
  private MethodChannel channel;

  private ChessEngineResolver resolver;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), CHANNEL);
    channel.setMethodCallHandler(this);
    resolver = new ChessEngineResolver(flutterPluginBinding.getApplicationContext());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("search")) {
      search(call, result);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  private void search(MethodCall call, MethodChannel.Result result) {
    List<ChessEngine> engines = resolver.resolveEngines();
    List<List<String>> resultList = new ArrayList<>();
    for (ChessEngine engine : engines) {
      resultList.add(Arrays.asList(new String[]{
              engine.getPackageName(), engine.getName(), "" + engine.getVersionCode(), engine.getFileName(), engine.getEnginePath()
      }));
    }
    result.success(resultList);
  }
}
