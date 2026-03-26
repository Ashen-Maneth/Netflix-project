import { formatBytes, formatMinuteToReadable, formatTime } from "./common";

describe("common utils", () => {
  test("formatMinuteToReadable formats hours and minutes", () => {
    expect(formatMinuteToReadable(130)).toBe("2h 10m");
    expect(formatMinuteToReadable(45)).toBe("45m");
  });

  test("formatBytes formats byte values", () => {
    expect(formatBytes(0)).toBe("0 Bytes");
    expect(formatBytes(1024)).toBe("1 KiB");
    expect(formatBytes(1536)).toBe("1.5 KiB");
  });

  test("formatTime formats mm:ss and hh:mm:ss", () => {
    expect(formatTime(65)).toBe("01:05");
    expect(formatTime(3661)).toBe("01:01:01");
  });
});
