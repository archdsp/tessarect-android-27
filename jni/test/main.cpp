#include <time.h>
#include "baseapi.h"
#include "allheaders.h"

int main()
{
    tesseract::TessBaseAPI *api = new tesseract::TessBaseAPI();
	clock_t start, end;
	
    // Initialize tesseract-ocr with English, without specifying tessdata path
    if (api->Init("/data/tessdata", "eng_fast")) {
        fprintf(stdout, "Could not initialize tesseract.\n");
        exit(1);
    }
	
    fprintf(stdout, "Successfully initialize tesseract.\n");

	start = clock();
	Pix *image = pixRead("/data/Temp/camImg1.png");
	api->SetImage(image);
    fprintf(stdout, "악마의 구간.\n");

	char *outText = api->GetUTF8Text();
	end = clock();

	if (outText != NULL)
	{
		fprintf(stdout, "[%.2f] result : %s\n", ((float)(end - start) / CLOCKS_PER_SEC), outText);
	}
    // Destroy used object and release memory
    api->End();
 
    return 0;
}
