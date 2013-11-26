public class TestOptionalJava {
  private static bridge_java bridge;

  public static void main(String[] args) {
    String path = args[0];
    System.load(path);
    bridge = new bridge_java();

    {
      optional_int v = new optional_int();
      System.out.println(v.is_initialized());
      System.out.println(v.get_value_or(69));
      v.set(105);
      System.out.println(v.is_initialized());
      System.out.println(v.get_value_or(69));
    }

    {
      optional_int v = new optional_int(42);
      System.out.println(v.is_initialized());
      System.out.println(v.get_value_or(69));
      v.reset();
      System.out.println(v.is_initialized());
      System.out.println(v.get_value_or(69));
    }

    {
      optional_string v = bridge.get_empty_optional_string();
      assert !v.is_initialized();

      v.set(bridge.get_optional_string());
      assert v.is_initialized();
      System.out.println(v.get());
    }

    {
      optional_sample v = new optional_sample();
      System.out.println("start");
      v.set(new sample());
      v.get().run();
      v.reset();
      System.out.println("end");
    }
  }
}
