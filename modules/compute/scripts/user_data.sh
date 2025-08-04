#!/bin/bash
yum update -y

# Apache HTTP Server のインストール
yum install -y httpd

# Apache の開始と自動起動設定
systemctl start httpd
systemctl enable httpd

# 簡単なHTMLページを作成
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${project_name} - ${environment}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 50px;
            background-color: #f0f0f0;
        }
        .container {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        .info {
            background-color: #e7f3ff;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .server-info {
            color: #666;
            font-size: 14px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 ${project_name}</h1>
        <div class="info">
            <h2>環境: ${environment}</h2>
            <p>Webサーバが正常に動作しています！</p>
        </div>
        <div class="server-info">
            <p>サーバー情報:</p>
            <p>ホスト名: $(hostname)</p>
            <p>起動時刻: $(date)</p>
            <p>インスタンスID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
            <p>アベイラビリティゾーン: $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>
        </div>
    </div>
</body>
</html>
EOF

# Apache の再起動
systemctl restart httpd