public class TestJava {
  public static void main(String[] args) {
    String path = args[0];
    System.load(path);

    Bridge.put_string("foo");
    String s = Bridge.get_string();
    System.out.println(s);

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
      optional_string v = Bridge.get_empty_optional_string();
      assert !v.is_initialized();

      v.set(Bridge.get_optional_string());
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
