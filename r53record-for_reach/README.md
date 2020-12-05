# r53record-for_reach

hostsファイルから aws_route53_record の for_reach のパラメタを生成する。

```bash
$ cat hosts.sample | awk '{printf("\"%s.morihaya.tech\" = \"%s\"\n",$2,$1)}'
```

以下がテンプレートで、生成したパラメタを挿入する。
```terraform
resource "aws_route53_record" "private" {
  zone_id = aws_route53_zone.private.zone_id
  for_each = {
    <ここへ生成したパラメタを入れる>
  }
  name    = each.key
  type    = "A"
  ttl     = "300"
  records = [each.value]
}
```
