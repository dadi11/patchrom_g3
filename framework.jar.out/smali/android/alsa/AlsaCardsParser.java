package android.alsa;

import android.net.ProxyInfo;
import android.util.Slog;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Vector;

public class AlsaCardsParser {
    private static final String TAG = "AlsaCardsParser";
    private static LineTokenizer tokenizer_;
    private Vector<AlsaCardRecord> cardRecords_;

    public class AlsaCardRecord {
        public String mCardDescription;
        public String mCardName;
        public int mCardNum;
        public String mField1;

        public AlsaCardRecord() {
            this.mCardNum = -1;
            this.mField1 = ProxyInfo.LOCAL_EXCL_LIST;
            this.mCardName = ProxyInfo.LOCAL_EXCL_LIST;
            this.mCardDescription = ProxyInfo.LOCAL_EXCL_LIST;
        }

        public boolean parse(String line, int lineIndex) {
            int tokenIndex;
            if (lineIndex == 0) {
                tokenIndex = AlsaCardsParser.tokenizer_.nextToken(line, AlsaCardsParser.tokenizer_.nextDelimiter(line, AlsaCardsParser.tokenizer_.nextToken(line, 0)));
                int delimIndex = AlsaCardsParser.tokenizer_.nextDelimiter(line, tokenIndex);
                this.mField1 = line.substring(tokenIndex, delimIndex);
                this.mCardName = line.substring(AlsaCardsParser.tokenizer_.nextToken(line, delimIndex));
            } else if (lineIndex == 1) {
                tokenIndex = AlsaCardsParser.tokenizer_.nextToken(line, 0);
                if (tokenIndex != -1) {
                    this.mCardDescription = line.substring(tokenIndex);
                }
            }
            return true;
        }

        public String textFormat() {
            return this.mCardName + " : " + this.mCardDescription;
        }
    }

    static {
        tokenizer_ = new LineTokenizer(" :[]");
    }

    public void scan() {
        this.cardRecords_.clear();
        String cardsFilePath = "/proc/asound/cards";
        try {
            FileReader reader = new FileReader(new File("/proc/asound/cards"));
            BufferedReader bufferedReader = new BufferedReader(reader);
            String str = ProxyInfo.LOCAL_EXCL_LIST;
            while (true) {
                str = bufferedReader.readLine();
                if (str != null) {
                    AlsaCardRecord cardRecord = new AlsaCardRecord();
                    cardRecord.parse(str, 0);
                    cardRecord.parse(bufferedReader.readLine(), 1);
                    this.cardRecords_.add(cardRecord);
                } else {
                    reader.close();
                    return;
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e2) {
            e2.printStackTrace();
        }
    }

    public AlsaCardRecord getCardRecordAt(int index) {
        return (AlsaCardRecord) this.cardRecords_.get(index);
    }

    public int getNumCardRecords() {
        return this.cardRecords_.size();
    }

    public void Log() {
        int numCardRecs = getNumCardRecords();
        for (int index = 0; index < numCardRecs; index++) {
            Slog.w(TAG, "usb:" + getCardRecordAt(index).textFormat());
        }
    }

    public AlsaCardsParser() {
        this.cardRecords_ = new Vector();
    }
}
